import 'package:server/server.dart';
import 'package:test/test.dart';

void main() {
  test('server ticks at the shared physics rate', () {
    expect(serverTickHz(), 60);
  });
}
