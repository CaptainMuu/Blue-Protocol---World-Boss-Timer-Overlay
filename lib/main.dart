import 'package:bp_world_boss/models/boss.dart';

void main() {
  final boss = Boss(name: 'cos', respawnInterval: Duration(minutes: 60));
  print(boss.timeUntilNextSpawn());
}
