import 'package:flutter_test/flutter_test.dart';
import 'package:talk_room/main.dart';

void main() {
  testWidgets('Talk Room app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const TalkRoomApp());
    await tester.pumpAndSettle();
    expect(find.text('Talk Room'), findsOneWidget);
  });
}
