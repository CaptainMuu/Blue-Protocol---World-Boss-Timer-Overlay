import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bp_world_boss/UI/overlay_window.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(400, 300),
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

  runApp(WorldBossTimer());

  doWhenWindowReady(() {
    final window = appWindow;
    window.minSize = const Size(400, 300);
    window.size = const Size(400, 300);
    window.alignment = Alignment.topRight;
    window.title = "Boss Timer Overlay";
    window.show();
  });
}

class WorldBossTimer extends StatelessWidget {
  const WorldBossTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Boss Timer',
      home: OverlayWindow(),
    );
  }
}
