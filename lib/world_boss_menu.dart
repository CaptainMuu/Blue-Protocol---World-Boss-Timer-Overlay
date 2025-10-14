import 'package:bp_world_boss/UI/boss_list_menu.dart';
import 'package:flutter/material.dart';

class WorldBossTimerMenu extends StatelessWidget {
  const WorldBossTimerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nordic',
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      title: 'World Boss Timer',
      home: BossListMenu(),
    );
  }
}
