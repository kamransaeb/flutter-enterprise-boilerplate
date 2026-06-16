import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Check if biometric authentication is available
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print('Error checking biometric availability: $e');
      return false;
    }
  }

  // Get available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print('Error getting available biometrics: $e');
      return [];
    }
  }

  // Check if device has biometric hardware
  Future<bool> hasBiometricHardware() async {
    try {
      final biometrics = await getAvailableBiometrics();
      return biometrics.isNotEmpty;
    } on PlatformException catch (e) {
      print('Error checking biometric hardware: $e');
      return false;
    }
  }

  // Check if fingerprint is available
  Future<bool> isFingerprintAvailable() async {
    try {
      final biometrics = await getAvailableBiometrics();
      return biometrics.contains(BiometricType.fingerprint);
    } on PlatformException catch (e) {
      print('Error checking fingerprint availability: $e');
      return false;
    }
  }

  // Check if face ID is available
  Future<bool> isFaceIdAvailable() async {
    try {
      final biometrics = await getAvailableBiometrics();
      return biometrics.contains(BiometricType.face);
    } on PlatformException catch (e) {
      print('Error checking face ID availability: $e');
      return false;
    }
  }

  // Check if iris scanner is available
  Future<bool> isIrisAvailable() async {
    try {
      final biometrics = await getAvailableBiometrics();
      return biometrics.contains(BiometricType.iris);
    } on PlatformException catch (e) {
      print('Error checking iris availability: $e');
      return false;
    }
  }

  // Authenticate with biometrics
  Future<bool> authenticate({
    required String reason,
    bool stickyAuth = false,
    bool useErrorDialogs = true,
    bool sensitiveTransaction = true,
    String? cancelButtonText,
    String? localizedFallbackTitle,
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          stickyAuth: stickyAuth,
          useErrorDialogs: useErrorDialogs,
          sensitiveTransaction: sensitiveTransaction,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print('Biometric authentication error: $e');
      return false;
    }
  }

  // Authenticate with biometrics or device credentials
  Future<bool> authenticateWithCredentials({
    required String reason,
    String? cancelButtonText,
    String? localizedFallbackTitle,
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
          biometricOnly: false, // Allow device credentials
        ),
      );
    } on PlatformException catch (e) {
      print('Authentication error: $e');
      return false;
    }
  }

  // Stop authentication
  Future<void> stopAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
    } on PlatformException catch (e) {
      print('Error stopping authentication: $e');
    }
  }

  // Check if biometrics are enrolled
  Future<bool> isBiometricEnrolled() async {
    try {
      final canAuthenticate = await _localAuth.canCheckBiometrics;
      if (!canAuthenticate) return false;
      
      final biometrics = await getAvailableBiometrics();
      if (biometrics.isEmpty) return false;
      
      // Try to authenticate to check enrollment
      final result = await authenticate(
        reason: 'Check biometric enrollment',
        stickyAuth: false,
        useErrorDialogs: false,
      );
      
      return result;
    } on PlatformException catch (e) {
      if (e.code == 'NotAvailable' || e.code == 'NotEnrolled') {
        return false;
      }
      print('Error checking biometric enrollment: $e');
      return false;
    }
  }

  // Get biometric authentication strength
  Future<BiometricStrength> getBiometricStrength() async {
    try {
      final biometrics = await getAvailableBiometrics();
      
      if (biometrics.contains(BiometricType.face)) {
        return BiometricStrength.strong;
      } else if (biometrics.contains(BiometricType.fingerprint)) {
        return BiometricStrength.medium;
      } else if (biometrics.contains(BiometricType.iris)) {
        return BiometricStrength.strong;
      } else {
        return BiometricStrength.weak;
      }
    } on PlatformException catch (e) {
      print('Error getting biometric strength: $e');
      return BiometricStrength.weak;
    }
  }

  // Encrypt data with biometrics
  Future<String?> encryptWithBiometrics(String data, {required String reason}) async {
    try {
      final authenticated = await authenticate(reason: reason);
      if (!authenticated) return null;
      
      // In a real app, you would use Flutter Secure Storage or similar
      // to store encrypted data that requires biometrics to access
      return 'encrypted_$data'; // Placeholder
    } on PlatformException catch (e) {
      print('Error encrypting with biometrics: $e');
      return null;
    }
  }

  // Decrypt data with biometrics
  Future<String?> decryptWithBiometrics(String encryptedData, {required String reason}) async {
    try {
      final authenticated = await authenticate(reason: reason);
      if (!authenticated) return null;
      
      // In a real app, you would retrieve and decrypt the data
      return encryptedData.replaceFirst('encrypted_', ''); // Placeholder
    } on PlatformException catch (e) {
      print('Error decrypting with biometrics: $e');
      return null;
    }
  }

  // Get biometric authentication status
  Future<BiometricStatus> getBiometricStatus() async {
    try {
      final available = await isBiometricAvailable();
      if (!available) return BiometricStatus.notAvailable;
      
      final enrolled = await isBiometricEnrolled();
      if (!enrolled) return BiometricStatus.notEnrolled;
      
      final hasHardware = await hasBiometricHardware();
      if (!hasHardware) return BiometricStatus.notSupported;
      
      return BiometricStatus.available;
    } on PlatformException catch (e) {
      print('Error getting biometric status: $e');
      return BiometricStatus.unknown;
    }
  }

  // Get human-readable biometric type
  String getBiometricTypeName(BiometricType type) {
    switch (type) {
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.iris:
        return 'Iris Scanner';
      case BiometricType.strong:
        return 'Strong Biometric';
      case BiometricType.weak:
        return 'Weak Biometric';
    }
  }

  // Get all biometric type names
  Future<List<String>> getAvailableBiometricNames() async {
    final biometrics = await getAvailableBiometrics();
    return biometrics.map(getBiometricTypeName).toList();
  }

  // Check if biometrics should be used (based on security requirements)
  Future<bool> shouldUseBiometrics({
    required SecurityLevel requiredLevel,
  }) async {
    final strength = await getBiometricStrength();
    
    switch (requiredLevel) {
      case SecurityLevel.low:
        return strength.index >= BiometricStrength.weak.index;
      case SecurityLevel.medium:
        return strength.index >= BiometricStrength.medium.index;
      case SecurityLevel.high:
        return strength.index >= BiometricStrength.strong.index;
      case SecurityLevel.critical:
        return false; // Biometrics not sufficient for critical security
    }
  }
}

enum BiometricStrength {
  weak,    // Basic biometrics
  medium,  // Standard fingerprint
  strong,  // Face ID, Iris scanner
}

enum BiometricStatus {
  available,
  notAvailable,
  notEnrolled,
  notSupported,
  unknown,
}

enum SecurityLevel {
  low,      // Public information
  medium,   // Personal information
  high,     // Financial information
  critical, // Sensitive data
}