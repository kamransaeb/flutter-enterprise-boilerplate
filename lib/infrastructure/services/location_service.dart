import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:geocoding/geocoding.dart';

@singleton
class LocationService {
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamController<Position>? _positionStreamController;


  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await _geolocator.isLocationServiceEnabled();
  }

  // Check location permission
  Future<LocationPermission> checkPermission() async {
    return await _geolocator.checkPermission();
  }

  // Request location permission
  Future<LocationPermission> requestPermission() async {
    return await _geolocator.requestPermission();
  }

  // Get current position
  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.best,
    bool forceAndroidLocationManager = false,
    Duration? timeLimit,
  }) async {
    // Check permissions first
    final permission = await checkPermission();
    if (permission == LocationPermission.denied) {
      final requested = await requestPermission();
      if (requested == LocationPermission.denied ||
          requested == LocationPermission.deniedForever) {
        throw LocationPermissionException('Location permission denied');
      }
    }

   final locationSettings = _buildLocationSettings(
    accuracy: accuracy,
    forceAndroidLocationManager: forceAndroidLocationManager,
    timeLimit: timeLimit,
   );
    return await _geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  // Get last known position
  // Android: forceLocationManager:
  // true → use legacy LocationManager;
  // false → use Fused Location Provider.
  // iOS: the value is ignored; Core Location is always used.
  Future<Position?> getLastKnownPosition({
    bool forceAndroidLocationManager = false,
  }) async {
    return await _geolocator.getLastKnownPosition(
      forceLocationManager: forceAndroidLocationManager,
    );
  }

  // Start listening to position updates
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.best,
    int distanceFilter = 0,
    bool forceAndroidLocationManager = false,
    Duration? timeInterval,
  }) {
    _positionStreamController ??= StreamController<Position>.broadcast();
    
    _positionStreamSubscription?.cancel();

    final locationSettings = _buildLocationSettings(
      accuracy: accuracy,
      forceAndroidLocationManager: forceAndroidLocationManager,
      timeLimit: timeInterval,
    );

    _positionStreamSubscription = _geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (position) {
        _positionStreamController?.add(position);
      },
      onError: (error, stackTrace) {
        _positionStreamController?.addError(error as Object, stackTrace as StackTrace?);
      },
    );

    return _positionStreamController!.stream;
  }

  // Stop listening to position updates
  Future<void> stopPositionUpdates() async {
    await _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    await _positionStreamController?.close();
    _positionStreamController = null;
  }

  // Calculate distance between two coordinates
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return _geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Check if position is within radius
  bool isWithinRadius({
    required double centerLatitude,
    required double centerLongitude,
    required double radiusInMeters,
    required double targetLatitude,
    required double targetLongitude,
  }) {
    final distance = calculateDistance(
      centerLatitude,
      centerLongitude,
      targetLatitude,
      targetLongitude,
    );
    
    return distance <= radiusInMeters;
  }

  // Get address from coordinates
  Future<Placemark> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    final placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    
    if (placemarks.isNotEmpty) {
      return placemarks.first;
    }
    
    throw Exception('No address found for coordinates');
  }

  // Get coordinates from address
  Future<LocationCoordinates> getCoordinatesFromAddress(String address) async {
    final locations = await locationFromAddress(address);
    
    if (locations.isNotEmpty) {
      final location = locations.first;
      return LocationCoordinates(
        latitude: location.latitude,
        longitude: location.longitude,
      );
    }
    
    throw Exception('No coordinates found for address');
  }

  // Get formatted address
  Future<String> getFormattedAddress(double latitude, double longitude) async {
    final placemark = await getAddressFromCoordinates(latitude, longitude);
    
    return [
      if (placemark.street != null) placemark.street,
      if (placemark.subLocality != null) placemark.subLocality,
      if (placemark.locality != null) placemark.locality,
      if (placemark.administrativeArea != null) placemark.administrativeArea,
      if (placemark.postalCode != null) placemark.postalCode,
      if (placemark.country != null) placemark.country,
    ].where((part) => part != null && part.isNotEmpty).join(', ');
  }

  // Check if location accuracy is sufficient
  bool isAccuracySufficient(Position position, LocationAccuracy requiredAccuracy) {
    final positionAccuracy = position.accuracy ?? 0;
    
    switch (requiredAccuracy) {
      case LocationAccuracy.reduced:
        return positionAccuracy <= 10000; // 10km
      case LocationAccuracy.lowest:
        return positionAccuracy <= 3000; // 3km
      case LocationAccuracy.low:
        return positionAccuracy <= 1000; // 1km
      case LocationAccuracy.medium:
        return positionAccuracy <= 100; // 100m
      case LocationAccuracy.high:
        return positionAccuracy <= 10; // 10m
      case LocationAccuracy.best:
        return positionAccuracy <= 5; // 5m
      case LocationAccuracy.bestForNavigation:
        return positionAccuracy <= 5; // 5m
    }
  }

  // Get bearing between two coordinates
  double getBearing(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return _geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Check if device is moving
  Future<bool> isDeviceMoving({
    required Duration checkInterval,
    required double movementThreshold,
  }) async {
    final positions = <Position>[];
    final stream = getPositionStream(
      accuracy: LocationAccuracy.medium,
      timeInterval: checkInterval,
    );
    
    final subscription = stream.listen((position) {
      positions.add(position);
      if (positions.length > 2) {
        positions.removeAt(0);
      }
    });
    
    await Future.delayed(checkInterval * 2);
    await subscription.cancel();
    await stopPositionUpdates();
    
    if (positions.length < 2) return false;
    
    final distance = calculateDistance(
      positions[0].latitude,
      positions[0].longitude,
      positions[1].latitude,
      positions[1].longitude,
    );
    
    return distance > movementThreshold;
  }

  // Get speed in km/h
  double getSpeedKmh(Position position) {
    final speed = position.speed ?? 0;
    return speed * 3.6; // Convert m/s to km/h
  }

  // Get speed in mph
  double getSpeedMph(Position position) {
    final speed = position.speed ?? 0;
    return speed * 2.237; // Convert m/s to mph
  }

  // Check if GPS signal is strong
  bool hasStrongGpsSignal(Position position) {
    return position.accuracy != null && position.accuracy! < 20;
  }

  // Get altitude in meters/feet
  double getAltitude(Position position, {bool inFeet = false}) {
    final altitude = position.altitude;
    if (inFeet) {
      return altitude * 3.28084; // Convert meters to feet
    }
    return altitude;
  }

  LocationSettings _buildLocationSettings({
  LocationAccuracy accuracy = LocationAccuracy.best,
  bool forceAndroidLocationManager = false,
  Duration? timeLimit,
  int distanceFilter = 0,
}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidSettings(
      accuracy: accuracy,
      forceLocationManager: forceAndroidLocationManager,
      timeLimit: timeLimit,
      distanceFilter: distanceFilter,
    );
  }
  return LocationSettings(
    accuracy: accuracy,
    timeLimit: timeLimit,
    distanceFilter: distanceFilter,
  );
}

  // Dispose resources
  Future<void> dispose() async {
    await stopPositionUpdates();
  }
}

class LocationCoordinates {
  final double latitude;
  final double longitude;

  LocationCoordinates({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => '($latitude, $longitude)';
}

class LocationPermissionException implements Exception {
  final String message;

  LocationPermissionException(this.message);

  @override
  String toString() => 'LocationPermissionException: $message';
}