import 'package:flutter/material.dart';
import 'package:flutter_qualidade_software/extra_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_qualidade_software/main.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class RouteFake extends Fake implements Route {}

void main() {
  Widget? testingWidget;
  MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

  setUpAll(() {
    registerFallbackValue(RouteFake());
  });

  setUp(() {
    testingWidget = MaterialApp(
      navigatorObservers: [mockNavigatorObserver],
      home: const MyApp(),
    );
  });
  testWidgets('content is presented', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(testingWidget!);

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    //Finds one widget of type Text, with text '0'
    final counterText = find.text('0');
    expect(counterText, findsOneWidget);

    // Finds multiple texts by type
    final textWidgets = find.byType(Text);
    expect(textWidgets, findsWidgets);
  });

  testWidgets('content is shown by Key', (tester) async {
    await tester.pumpWidget(testingWidget!);
    expect(find.byKey(const Key('title_text')), findsOneWidget);
    expect(find.byKey(const Key('counter_text')), findsOneWidget);
    expect(find.byKey(const Key('increment_counter_button')), findsOneWidget);
    expect(find.byKey(const Key('title_text')), findsOneWidget);
  });
  testWidgets('tap increment button', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(testingWidget!);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('tap increment button by Key', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(testingWidget!);
    expect(find.text('0'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    final button = find.byKey(const Key('increment_counter_button'));
    await tester.tap(button);
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(button);
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(button);
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('tap Open button', (tester) async {
    NavigatorObserver mockNavigator = MockNavigatorObserver();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [mockNavigator],
        home: const MyApp(),
      ),
    );
    final openButton = find.byType(ElevatedButton);

    await tester.tap(openButton);
    await tester.pumpAndSettle();

    verify(() => mockNavigator.didPush(any(), any()));
    expect(find.byType(ExtraScreen), findsOneWidget);
  });
}
