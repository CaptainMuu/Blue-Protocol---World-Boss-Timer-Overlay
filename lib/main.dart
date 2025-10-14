import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bp_world_boss/overlay_mode_main.dart';
import 'package:bp_world_boss/world_boss_menu.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  final isOverlay = args.isNotEmpty && args.first == '--overlay';
  final bossName = isOverlay ? args[1] : null;

  WindowOptions windowOptions = WindowOptions(
    center: false,
    backgroundColor: isOverlay ? Colors.transparent : Colors.white,
    skipTaskbar: isOverlay,
    titleBarStyle: isOverlay ? TitleBarStyle.hidden : TitleBarStyle.normal,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlwaysOnTop(isOverlay);
    await windowManager.show();
    await windowManager.focus();
  });

  doWhenWindowReady(() async {
    final window = appWindow;
    if (isOverlay) {
      window.minSize = const Size(10, 5);
      window.size = const Size(178, 53);
      window.alignment = Alignment.topRight;
      window.title = "Boss Timer Overlay";
    } else {
      window.minSize = const Size(200, 200);
      window.size = const Size(550, 800);
      window.title = "Boss Timer Menu";
    }
    window.show();
  });
  if (isOverlay) {
    runApp(WorldBossTimer(bossName: bossName!));
  } else {
    runApp(WorldBossTimerMenu());
  }
}
