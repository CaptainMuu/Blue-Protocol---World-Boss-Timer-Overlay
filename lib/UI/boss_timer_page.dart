import 'dart:async';

import 'package:bp_world_boss/models/boss.dart';
import 'package:flutter/material.dart';

class BossTimerPage extends StatefulWidget {
  const BossTimerPage({super.key});

  @override
  State<BossTimerPage> createState() => _BossTimerPageState();
}

class _BossTimerPageState extends State<BossTimerPage> {
  late Boss boss;
  Duration? timeRemaining;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    boss = Boss(name: 'Ice Troll', respawnInterval: 30);
  }

  void startTimer() {
    timer?.cancel(); //if some timer already exists - stop it
    timeRemaining =
        boss.timeUntilNextSpawn(); //time remaining to the next respawn
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      //turn on the timer to do setState each second
      setState(() {
        if (timeRemaining!.inSeconds > 0) {
          timeRemaining = timeRemaining! - const Duration(seconds: 1);
        } //when still some time remaining subtract 1 second
        else {
          t.cancel(); //if no time remaining - turn off the timer;
        }
      });
    });
  }

  //Cleaning
  void dispose() {
    timer?.cancel(); //stop any timer if present and running
    super.dispose(); //flutter cleanup
  }

  Widget build(BuildContext context) {
    final timeString =
        timeRemaining == null
            ? ('--:--')
            : (timeRemaining!.inMinutes.toString() +
                ':' +
                timeRemaining!.inSeconds.remainder(60).toString());
    //set time string to be a string value of timeRemaining - if it's null, then display --:--
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Next ${boss.name} will spawn in: '),
            Text(timeString),
            ElevatedButton(
              onPressed: startTimer,
              child: Text("show respawn time"),
            ),
          ],
        ),
      ),
    );
  }
}
