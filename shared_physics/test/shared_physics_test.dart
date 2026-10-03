import 'package:shared_physics/shared_physics.dart';
import 'package:test/test.dart';

void main() {
  test('physics runs at 60 ticks per second', () {
    expect(physicsTickHz, 60);
  });
}
