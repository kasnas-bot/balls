import 'package:balls/main.dart';
import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Flame game widget', (tester) async {
    await tester.pumpWidget(const MainApp());
    expect(find.byType(GameWidget<BallsGame>), findsOneWidget);
  });
}
