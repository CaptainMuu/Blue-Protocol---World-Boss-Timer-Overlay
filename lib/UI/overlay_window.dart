import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bp_world_boss/UI/boss_timer_page.dart';
import 'package:flutter/material.dart';

import '../models/boss.dart';

class OverlayWindow extends StatefulWidget {
  final Boss boss;
  const OverlayWindow({required this.boss, super.key});

  @override
  State<OverlayWindow> createState() => _OverlayWindowState();
}

class _OverlayWindowState extends State<OverlayWindow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  //Cleaning
  void dispose() {
    super.dispose(); //flutter cleanup
  }

  @override
  Widget build(BuildContext context) {
    return MoveWindow(
      child: Row(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: BossTimerPage(boss: widget.boss),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(1, 0, 1, 20),
            child: GestureDetector(
              onTap: () => appWindow.close(),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'X',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
