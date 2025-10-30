// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:greengologistics/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
  // The original template used MyApp and a counter. This project uses
  // GreenGoApp as the root. We verify that the app builds by pumping it.
  await tester.pumpWidget(const GreenGoApp());

  // Quick smoke check: App has title text in the AppBar.
  expect(find.textContaining('GreenGo'), findsOneWidget);
  });
}
