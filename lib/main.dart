import 'package:bp_world_boss/UI/boss_timer_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(WorldBossTimer());
}

class WorldBossTimer extends StatelessWidget {
  const WorldBossTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'World Boss Timer', home: BossTimerPage());
  }
}
