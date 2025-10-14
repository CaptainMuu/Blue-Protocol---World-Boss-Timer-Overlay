import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bp_world_boss/UI/boss_list_menu.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(center: false);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlwaysOnTop(true);
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(WorldBossTimerMenu());

  doWhenWindowReady(() {
    final window = appWindow;
    window.minSize = const Size(200, 200);
    window.size = const Size(800, 400);
    window.title = "Boss Timer Menu";
    window.show();
  });
}

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
