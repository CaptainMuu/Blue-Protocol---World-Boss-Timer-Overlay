import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bp_world_boss/overlay_mode_main.dart';
import 'package:bp_world_boss/world_boss_menu.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (args.isNotEmpty && args.first == '--overlay') {
    final bossName = args[1];
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      center: false,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAlwaysOnTop(true);
      await windowManager.show();
      await windowManager.focus();
    });

    doWhenWindowReady(() {
      final window = appWindow;
      window.minSize = const Size(10, 5);
      window.size = const Size(178, 53);
      window.alignment = Alignment.topRight;
      window.title = "Boss Timer Overlay";
      window.show();
    });

    runApp(WorldBossTimer(bossName: bossName));
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(center: false);

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAlwaysOnTop(false);
      await windowManager.show();
      await windowManager.focus();
    });
    doWhenWindowReady(() {
      final window = appWindow;
      window.minSize = const Size(200, 200);
      window.size = const Size(400, 800);
      window.title = "Boss Timer Menu";
      window.show();
    });
    runApp(WorldBossTimerMenu());
  }
}
