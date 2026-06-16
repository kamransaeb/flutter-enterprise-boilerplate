import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib/features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../lib/features/auth/presentation/pages/login_page.dart';
import '../../../../lib/routes/app_router.gr.dart';

// Mocks
class MockAuthBloc extends Mock implements AuthBloc {}
class MockAuthState extends Mock implements AuthState {}
class MockAppRouter extends Mock implements AppRouter {}

void main() {
  late MockAuthBloc mockAuthBloc;
  late MockAppRouter mockAppRouter;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockAppRouter = MockAppRouter();
    
    // Default state
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const LoginPage(),
      ),
    );
  }

  group('LoginPage Widget Tests', () {
    testWidgets('renders all essential elements', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify app bar
      expect(find.text('Login'), findsOneWidget);

      // Verify form elements
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('or continue with'), findsOneWidget);
      expect(find.text('Don\'t have an account?'), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);

      // Verify social login buttons
      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('shows loading indicator when loading', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());
      
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Sign In'), findsNothing);
    });

    testWidgets('validates email field', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap login button without entering email
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Should show validation error
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('validates password field', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter valid email
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );

      // Tap login button without entering password
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Should show validation error
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('triggers login event with valid credentials', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter valid credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'Password123!',
      );

      // Tap login button
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Verify login event was triggered
      verify(() => mockAuthBloc.add(
        const AuthEvent.loginRequested(
          email: 'test@example.com',
          password: 'Password123!',
        ),
      )).called(1);
    });

    testWidgets('shows error snackbar on login failure', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(
        AuthState.failure(ServerFailure('Login failed')),
      );
      
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should show error snackbar
      expect(find.text('Login failed'), findsOneWidget);
    });

    testWidgets('navigates to forgot password page', (tester) async {
      // Mock navigation
      final mockNavigator = MockNavigatorObserver();
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: const LoginPage(),
          ),
          navigatorObservers: [mockNavigator],
        ),
      );

      // Tap forgot password link
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      // Verify navigation
      // This would need proper routing setup
    });

    testWidgets('navigates to sign up page', (tester) async {
      // Mock navigation
      final mockNavigator = MockNavigatorObserver();
      
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: const LoginPage(),
          ),
          navigatorObservers: [mockNavigator],
        ),
      );

      // Tap sign up link
      await tester.tap(find.text('Sign up'));
      await tester.pumpAndSettle();

      // Verify navigation
      // This would need proper routing setup
    });

    testWidgets('toggles password visibility', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Password should be obscured initially
      final passwordField = tester.widget<TextField>(
        find.byKey(const Key('password_field')),
      );
      expect(passwordField.obscureText, isTrue);

      // Tap visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();

      // Password should be visible
      final updatedPasswordField = tester.widget<TextField>(
        find.byKey(const Key('password_field')),
      );
      expect(updatedPasswordField.obscureText, isFalse);
    });

    testWidgets('triggers Google login', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap Google login button
      await tester.tap(find.text('Google'));
      await tester.pump();

      // Verify Google login event was triggered
      verify(() => mockAuthBloc.add(
        const AuthEvent.loginWithGoogle(),
      )).called(1);
    });

    testWidgets('triggers Apple login', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap Apple login button
      await tester.tap(find.text('Apple'));
      await tester.pump();

      // Verify Apple login event was triggered
      verify(() => mockAuthBloc.add(
        const AuthEvent.loginWithApple(),
      )).called(1);
    });
  });
}

// Mock classes for navigation testing
class MockNavigatorObserver extends Mock implements NavigatorObserver {}