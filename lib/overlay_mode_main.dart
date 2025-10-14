import 'dart:convert';

import 'package:bp_world_boss/UI/overlay_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'models/boss.dart';

class WorldBossTimer extends StatefulWidget {
  final String bossName;
  const WorldBossTimer({required this.bossName, super.key});

  @override
  State<WorldBossTimer> createState() => _WorldBossTimerState();
}

class _WorldBossTimerState extends State<WorldBossTimer> {
  late Future<Boss> bossFuture;

  void initState() {
    super.initState();
    bossFuture = MatchBossNameWithBoss(widget.bossName);
  }

  Future<Boss> MatchBossNameWithBoss(String name) async {
    final data = await rootBundle.loadString('assets/data/bosses.json');
    final List<dynamic> jsonList = jsonDecode(data);
    final bossJson = jsonList.firstWhere(
      (element) => element['name'] == name,
      orElse: () => throw Exception("Boss $name not found"),
    );
    return Boss.fromJson(bossJson);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Boss>(
      future: bossFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error:{$snapshot.error}'));
        } else {
          final boss = snapshot.data!;
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Nordic',
              textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
            ),
            debugShowCheckedModeBanner: false,
            title: 'World Boss Timer',
            home: OverlayWindow(boss: boss),
          );
        }
      },
    );
  }
}
