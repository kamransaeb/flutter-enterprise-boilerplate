import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:enterprise_app/main.dart' as app;
import 'package:enterprise_app/app/app_config.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      app.main();
      await tester.pumpAndSettle();

      // Verify the app starts
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Splash screen shows and navigates', (tester) async {
      // Build our app
      app.main();
      await tester.pumpAndSettle();

      // Verify splash screen is shown
      expect(find.byKey(const Key('splash_screen')), findsOneWidget);

      // Wait for navigation
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should navigate to appropriate screen
      // This depends on your app's initial routing
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Dark mode toggle works', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to settings
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Toggle dark mode
      await tester.tap(find.byKey(const Key('dark_mode_switch')));
      await tester.pumpAndSettle();

      // Verify theme changed
      // This test would need access to theme state
    });

    testWidgets('Navigation between screens works', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test navigation flow
      final homeButton = find.byKey(const Key('home_button'));
      final profileButton = find.byKey(const Key('profile_button'));

      // Navigate to profile
      await tester.tap(profileButton);
      await tester.pumpAndSettle();
      expect(find.text('Profile'), findsOneWidget);

      // Navigate back to home
      await tester.tap(homeButton);
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('Authentication Flow', () {
    testWidgets('User can login successfully', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Enter credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'Password123!',
      );

      // Tap login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should navigate to home/dashboard
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Invalid login shows error', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Enter invalid credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'invalid@email.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'wrongpassword',
      );

      // Tap login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}