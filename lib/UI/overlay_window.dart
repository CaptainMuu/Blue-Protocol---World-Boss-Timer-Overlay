import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bp_world_boss/UI/boss_timer_page.dart';
import 'package:flutter/material.dart';

class OverlayWindow extends StatefulWidget {
  const OverlayWindow({super.key});

  @override
  State<OverlayWindow> createState() => _OverlayWindowState();
}

class _OverlayWindowState extends State<OverlayWindow> {
  @override
  void initState() {
    super.initState();
  }

  //Cleaning
  void dispose() {
    super.dispose(); //flutter cleanup
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WindowTitleBarBox(
        child: MoveWindow(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: BossTimerPage(),
            ),
          ),
        ),
      ),
    );
  }
}
