import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Global test setup
void configureTestEnvironment() {
  // Set up mocking
  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeRequestOptions());
  });

  // Reset mocks after each test
  tearDown(() {
    resetMocktailState();
  });
}

// Test utilities
class FakeRequestOptions extends Fake implements RequestOptions {
  @override
  Uri get uri => Uri.parse('https://test.example.com');
}

// Custom matchers
Matcher isRight<T>() {
  return isA<Right>().having(
    (r) => r.value,
    'value',
    isA<T>(),
  );
}

Matcher isLeft<L>() {
  return isA<Left>().having(
    (l) => l.value,
    'value',
    isA<L>(),
  );
}

Matcher isFailureWithMessage(String message) {
  return isA<Failure>().having(
    (f) => f.message,
    'message',
    equals(message),
  );
}

// Test helpers
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final endTime = tester.binding.clock.fromNowBy(timeout);
  
  do {
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 100));
  } while (tester.binding.clock.now().isBefore(endTime) && finder.evaluate().isEmpty);
  
  expect(finder, findsOneWidget);
}

extension WidgetTesterExtensions on WidgetTester {
  Future<void> tapAndSettle(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
  }

  Future<void> enterTextAndSettle(Finder finder, String text) async {
    await enterText(finder, text);
    await pumpAndSettle();
  }

  Future<void> dragUntilVisible(
    Finder item,
    Finder scrollable,
    Offset moveStep, {
    int maxIteration = 50,
  }) async {
    var iteration = 0;
    
    while (iteration < maxIteration && item.evaluate().isEmpty) {
      await drag(scrollable, moveStep);
      await pumpAndSettle();
      iteration++;
    }
    
    expect(item, findsOneWidget);
  }
}