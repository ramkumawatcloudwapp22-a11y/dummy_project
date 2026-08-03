import 'package:flutter_test/flutter_test.dart';
import 'package:dummy_project/main.dart';

void main() {
  testWidgets('App launches splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const TechYodhaApp());
    expect(find.text('TECH YODHA'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
  });
}
