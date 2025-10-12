import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bp_world_boss/UI/overlay_window.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
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

  runApp(WorldBossTimer());

  doWhenWindowReady(() {
    final window = appWindow;
    window.minSize = const Size(10, 5);
    window.size = const Size(178, 53);
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
      theme: ThemeData(
        fontFamily: 'Nordic',
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      title: 'World Boss Timer',
      home: OverlayWindow(),
    );
  }
}
