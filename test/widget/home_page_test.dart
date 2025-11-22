import 'package:flutter_test/flutter_test.dart';
import 'package:rolla_demo_app/main.dart';

void main() {
  testWidgets('App starts and shows home', (WidgetTester tester) async {
    await tester.pumpWidget(const RollaApp());
    await tester.pumpAndSettle();
    expect(find.text('Scores'), findsOneWidget);
  });
}
