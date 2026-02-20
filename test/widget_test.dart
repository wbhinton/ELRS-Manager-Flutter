import 'package:flutter_test/flutter_test.dart';
import 'package:elrs_mobile/src/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Allow the splash screen timer and animations to complete
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that the App is present
    expect(find.byType(App), findsOneWidget);
  });
}
