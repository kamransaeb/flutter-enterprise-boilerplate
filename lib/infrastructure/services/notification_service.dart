import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

@singleton
class NotificationService {
  final LoggerService _logger;
  final EnvironmentService _env;
  final LocalStorage _secureStorage;
  final FlutterLocalNotificationsPlugin _localNotifications;
  
  // Stream for notification taps
  final BehaviorSubject<Map<String, dynamic>> _onNotificationTap = BehaviorSubject();
  
  bool _isInitialized = false;
  String? _deviceToken;

  // Public stream for listening to notification taps
  Stream<Map<String, dynamic>> get onNotificationTap => _onNotificationTap.stream;

  NotificationService(this._env, @Named('secure_storage') this._secureStorage, this._logger)
      : _localNotifications = FlutterLocalNotificationsPlugin();

  /// Initialize notification service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _logger.i('[Notifications] Initializing notification service...');

      // Initialize timezone data
      tz.initializeTimeZones();

      // Initialize Android settings
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      
      // Initialize iOS settings
      final iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );

      // Initialize platform settings
      final settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Initialize plugin
      await _localNotifications.initialize(
        settings,
        onDidReceiveNotificationResponse: _onSelectNotification,
        onDidReceiveBackgroundNotificationResponse: _onSelectNotificationBackground,
      );

      // Request permissions
      await _requestPermissions();

      // Create notification channels
      await _createNotificationChannels();

      _isInitialized = true;
      _logger.i('[Notifications] Notification service initialized');
    } catch (e, stack) {
      _logger.e('[Notifications] Failed to initialize notification service', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Request notification permissions
  Future<bool> _requestPermissions() async {
    try {
      if (Theme.of(GetIt.instance<GlobalKey<NavigatorState>>().currentContext!).platform == TargetPlatform.iOS) {
        final result = await _localNotifications.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return result ?? false;
      } else {
        final result = await _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
        return result ?? false;
      }
    } catch (e, stack) {
      _logger.e('[Notifications] Failed to request notification permissions', error: e, stackTrace: stack);
      return false;
    }
  }

  /// Create notification channels (Android)
  Future<void> _createNotificationChannels() async {
    if (Theme.of(GetIt.instance<GlobalKey<NavigatorState>>().currentContext!).platform != TargetPlatform.android) {
      return;
    }

    final androidPlugin = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    // General notifications channel
    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        _env.getNotificationChannelId('general'),
        'General Notifications',
        description: 'General app notifications',
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        ledColor: Colors.blue,
      ),
    );

    // Important notifications channel
    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        _env.getNotificationChannelId('important'),
        'Important Notifications',
        description: 'Important alerts and updates',
        importance: Importance.max,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        ledColor: Colors.red,
        enableLights: true,
      ),
    );

    // Marketing notifications channel
    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        _env.getNotificationChannelId('marketing'),
        'Marketing',
        description: 'Promotions and offers',
        importance: Importance.low,
        enableVibration: false,
        playSound: false,
        showBadge: false,
      ),
    );

    // Silent notifications channel
    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        _env.getNotificationChannelId('silent'),
        'Silent Updates',
        description: 'Background updates',
        importance: Importance.min,
        enableVibration: false,
        playSound: false,
        showBadge: false,
        enableLights: false,
      ),
    );

    // Progress notifications channel
    await androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        _env.getNotificationChannelId('progress'),
        'Progress',
        description: 'Download/Upload progress',
        importance: Importance.low,
        enableVibration: false,
        playSound: false,
        showBadge: false,
      ),
    );
  }

  /// Show a local notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? channelId,
    NotificationDetails? details,
    DateTime? scheduledDate,
  }) async {
    if (!_isInitialized) {
      _logger.w('[Notifications] Notification service not initialized');
      return;
    }

    try {
      final notificationDetails = details ?? await _createNotificationDetails(channelId);

      if (scheduledDate != null) {
        // Schedule notification
        await _localNotifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
        );
        _logger.i('[Notifications] Scheduled notification: $title for $scheduledDate');
      } else {
        // Show immediately
        await _localNotifications.show(
          id,
          title,
          body,
          notificationDetails,
          payload: payload,
        );
        _logger.i('[Notifications] Shown notification: $title');
      }
    } catch (e, stack) {
      _logger.e('[Notifications] Failed to show notification', error: e, stackTrace: stack);
    }
  }

  /// Show a notification with custom styling
  Future<void> showStyledNotification({
    required int id,
    required String title,
    required String body,
    String? largeIcon,
    String? bigPicture,
    NotificationStyle style = NotificationStyle.default_,
    String? channelId,
    DateTime? scheduledDate,
    Map<String, dynamic>? data,
  }) async {
    final payload = data != null ? jsonEncode(data) : null;
    
    final androidDetails = await _createAndroidDetails(
      channelId: channelId ?? _env.getNotificationChannelId('general'),
      style: style,
      largeIcon: largeIcon,
      bigPicture: bigPicture,
    );

    final iosDetails = await _createIOSDetails();

    await showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
      details: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      scheduledDate: scheduledDate,
    );
  }

  /// Show a progress notification
  Future<void> showProgressNotification({
    required int id,
    required String title,
    required String body,
    required int currentProgress,
    required int maxProgress,
    bool indeterminate = false,
    String? channelId,
    Map<String, dynamic>? data,
  }) async {
    final payload = data != null ? jsonEncode(data) : null;
    
    final androidDetails = AndroidNotificationDetails(
      channelId ?? _env.getNotificationChannelId('progress'),
      'Progress',
      channelDescription: 'Progress notifications',
      importance: Importance.low,
      priority: Priority.low,
      showProgress: true,
      maxProgress: maxProgress,
      progress: currentProgress,
      indeterminate: indeterminate,
      onlyAlertOnce: true,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
    );

    await showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
      details: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
    );
  }

  /// Show a notification with action buttons
  Future<void> showActionNotification({
    required int id,
    required String title,
    required String body,
    required List<NotificationAction> actions,
    String? channelId,
    Map<String, dynamic>? data,
  }) async {
    final payload = data != null ? jsonEncode(data) : null;
    
    final androidActions = actions.map((action) {
      return AndroidNotificationAction(
        action.id,
        action.title,
         icon: action.icon != null
        ? DrawableResourceAndroidBitmap(action.icon!)
        : null,
        showsUserInterface: action.showsUserInterface,
        cancelNotification: action.cancelNotification,
      );
    }).toList();

    final androidDetails = AndroidNotificationDetails(
      channelId ?? _env.getNotificationChannelId('general'),
      'Actions',
      channelDescription: 'Action notifications',
      importance: Importance.high,
      priority: Priority.high,
      actions: androidActions,
    );

    final iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'actions',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
      details: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
    );
  }

  /// Show a recurring notification (daily, weekly, etc.)
  Future<void> showRecurringNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required Duration interval,
    String? channelId,
    Map<String, dynamic>? data,
  }) async {
    final payload = data != null ? jsonEncode(data) : null;
    final details = await _createNotificationDetails(channelId);

    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
    
    _logger.i('[Notifications] Scheduled recurring notification: $title');
  }

  /// Cancel a notification
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
    _logger.i('[Notifications] Cancelled notification: $id');
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
    _logger.i('[Notifications] Cancelled all notifications');
  }

  /// Get notification details from payload
  Map<String, dynamic>? getNotificationData(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    try {
      return jsonDecode(payload) as Map<String, dynamic>;
    } catch (e) {
      _logger.e('[Notifications] Failed to parse notification payload', error: e);
      return null;
    }
  }

  /// Check if notification permission is granted
  Future<bool> hasPermission() async {
    final platform = Theme.of(GetIt.instance<GlobalKey<NavigatorState>>().currentContext!).platform;
    
    if (platform == TargetPlatform.iOS) {
      final result = await _localNotifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()?.checkPermissions();
      return result?.isEnabled ?? false;
    } else {
      final result = await _localNotifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();
      return result ?? false;
    }
  }

  /// Get pending notification requests
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }

  /// Update device token (for FCM)
  Future<void> updateDeviceToken(String token) async {
    _deviceToken = token;
    await _secureStorage.write('fcm_token', token);
    _logger.i('[Notifications] Device token updated');
  }

  /// Get device token
  Future<String?> getDeviceToken() async {
    if (_deviceToken != null) return _deviceToken;
    _deviceToken = await _secureStorage.read('fcm_token');
    return _deviceToken;
  }

  /// Clear device token
  Future<void> clearDeviceToken() async {
    _deviceToken = null;
    await _secureStorage.delete('fcm_token');
    _logger.i('[Notifications] Device token cleared');
  }

  /// Create notification details
  Future<NotificationDetails> _createNotificationDetails([String? channelId]) async {
    return NotificationDetails(
      android: await _createAndroidDetails(channelId: channelId),
      iOS: await _createIOSDetails(),
    );
  }

  /// Create Android-specific details
  Future<AndroidNotificationDetails> _createAndroidDetails({
    String? channelId,
    NotificationStyle style = NotificationStyle.default_,
    String? largeIcon,
    String? bigPicture,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId ?? _env.getNotificationChannelId('general'),
      'Notifications',
      channelDescription: 'App notifications',
      importance: _getImportanceForStyle(style),
      priority: _getPriorityForStyle(style),
      ticker: 'ticker',
      showWhen: true,
      enableVibration: style != NotificationStyle.silent,
      playSound: style != NotificationStyle.silent,
      enableLights: style == NotificationStyle.important,
      ledColor: style == NotificationStyle.important ? Colors.red : Colors.blue,
      ledOnMs: 1000,
      ledOffMs: 500,
      styleInformation: _getStyleInformation(style, largeIcon, bigPicture),
      icon: '@mipmap/ic_launcher',
      channelShowBadge: style != NotificationStyle.silent,
      visibility: NotificationVisibility.public,
      category: _getCategoryForStyle(style),
    );

    return androidDetails;
  }

  /// Create iOS-specific details
  Future<DarwinNotificationDetails> _createIOSDetails() async {
    return const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
      interruptionLevel: InterruptionLevel.active,
    );
  }

  /// Get importance based on style
  Importance _getImportanceForStyle(NotificationStyle style) {
    switch (style) {
      case NotificationStyle.important:
        return Importance.max;
      case NotificationStyle.high:
        return Importance.high;
      case NotificationStyle.default_:
        return Importance.defaultImportance;
      case NotificationStyle.low:
        return Importance.low;
      case NotificationStyle.silent:
        return Importance.min;
    }
  }

  /// Get priority based on style
  Priority _getPriorityForStyle(NotificationStyle style) {
    switch (style) {
      case NotificationStyle.important:
        return Priority.max;
      case NotificationStyle.high:
        return Priority.high;
      case NotificationStyle.default_:
        return Priority.defaultPriority;
      case NotificationStyle.low:
        return Priority.low;
      case NotificationStyle.silent:
        return Priority.min;
    }
  }

  /// Get category for style
  AndroidNotificationCategory? _getCategoryForStyle(NotificationStyle style) {
        switch (style) {
      case NotificationStyle.important:
        return AndroidNotificationCategory.reminder;
      case NotificationStyle.high:
        return AndroidNotificationCategory.call;
      case NotificationStyle.default_:
        return AndroidNotificationCategory.message;
      case NotificationStyle.low:
        return AndroidNotificationCategory.promo;
      case NotificationStyle.silent:
        return AndroidNotificationCategory.service;
    }
  }

  /// Get style information
  StyleInformation? _getStyleInformation(
    NotificationStyle style,
    String? largeIcon,
    String? bigPicture,
  ) {
    if (style == NotificationStyle.silent) return null;

    if (bigPicture != null) {
      return BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicture),
        largeIcon: largeIcon != null ? FilePathAndroidBitmap(largeIcon) : null,
        contentTitle: null,
        summaryText: null,
        htmlFormatContentTitle: false,
        htmlFormatSummaryText: false,
      );
    }

    if (largeIcon != null) {
      return const BigTextStyleInformation(
        '',
        htmlFormatBigText: false,
        contentTitle: null,
        summaryText: null,
        htmlFormatContentTitle: false,
        htmlFormatSummaryText: false,
      );
    }

    return null;
  }

  /// Handle notification tap (iOS foreground)
  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    _logger.i('[Notifications] Local notification received in foreground');
    _handleNotificationTap(payload);
  }

  /// Handle notification selection
  void _onSelectNotification(NotificationResponse response) {
    _logger.i('[Notifications] Notification selected: ${response.payload}');
    _handleNotificationTap(response.payload);
  }

  /// Handle notification selection in background
  @pragma('vm:entry-point')
  static void _onSelectNotificationBackground(NotificationResponse response) {
    // Handle in background isolate - this runs in a separate isolate
    // Can't use GetIt or instance methods here
    print('Background notification tapped: ${response.payload}');
    
    // Store in SharedPreferences for later processing when app opens
    // This would require a static method or separate handling
  }

  /// Handle notification tap - adds to stream
  void _handleNotificationTap(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        _logger.i('[Notifications] Adding notification tap to stream: ${data.keys}');
        _onNotificationTap.add(data);
      } catch (e, stack) {
        _logger.e('[Notifications] Failed to parse notification payload on tap', error: e, stackTrace: stack);
        
        // Still add a basic entry with raw payload
        _onNotificationTap.add({
          'raw_payload': payload,
          'error': e.toString(),
        });
      }
    } else {
      _logger.i('[Notifications] Notification tapped with no payload');
      _onNotificationTap.add({});
    }
  }

  /// Get the stream as broadcast (for multiple listeners)
  Stream<Map<String, dynamic>> getNotificationStream() {
    return _onNotificationTap.stream.asBroadcastStream();
  }

  /// Dispose service
  void dispose() {
    _onNotificationTap.close();
    _logger.i('[Notifications] Notification service disposed');
  }
}

/// Notification style enum
enum NotificationStyle {
  important,
  high,
  default_,
  low,
  silent,
}

/// Notification action model
class NotificationAction {
  final String id;
  final String title;
  final String? icon;
  final bool showsUserInterface;
  final bool cancelNotification;

  NotificationAction({
    required this.id,
    required this.title,
    this.icon,
    this.showsUserInterface = true,
    this.cancelNotification = true,
  });
}

/// Extension for getting notification channel ID
extension EnvironmentServiceExtension on EnvironmentService {
  String getNotificationChannelId(String baseChannelId) {
    if (isDevelopment) return '${baseChannelId}_dev';
    if (isStaging) return '${baseChannelId}_staging';
    return baseChannelId;
  }
}
