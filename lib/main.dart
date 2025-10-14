import 'package:bp_world_boss/overlay_mode_main.dart';
import 'package:bp_world_boss/world_boss_menu.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (args.isNotEmpty && args.first == '--overlay') {
    final bossName = args[1];
    runApp(WorldBossTimer(bossName: bossName));
  } else {
    runApp(WorldBossTimerMenu());
  }
}
