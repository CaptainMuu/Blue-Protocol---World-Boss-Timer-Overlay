import 'dart:io';

import 'package:bp_world_boss/overlay_mode_main.dart';
import 'package:bp_world_boss/world_boss_menu.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  print('Args: $args');
  final exeDir = File(Platform.resolvedExecutable).parent;
  Directory.current = exeDir;
  final isOverlay = args.isNotEmpty;
  final bossName = isOverlay ? args[0] : null;

  WindowOptions windowOptions = WindowOptions(
    center: false,
    backgroundColor: isOverlay ? Colors.transparent : Colors.white,
    skipTaskbar: isOverlay,
    titleBarStyle: isOverlay ? TitleBarStyle.hidden : TitleBarStyle.normal,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlwaysOnTop(isOverlay);
    if (isOverlay) {
      await windowManager.setSize(Size(178, 53));
    } else {
      await windowManager.setSize(Size(550, 800));
    }
    await windowManager.show();
    await windowManager.focus();
  });

  if (isOverlay) {
    runApp(WorldBossTimer(bossName: bossName!));
  } else {
    runApp(WorldBossTimerMenu());
  }
}
