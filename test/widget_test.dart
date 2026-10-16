import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_buddy/main.dart';

void main() {
  testWidgets('LingoBuddy App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LingoBuddyApp());
    expect(find.text('LingoBuddy B1'), findsOneWidget);
  });
}
