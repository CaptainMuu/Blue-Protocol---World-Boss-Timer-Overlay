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
    boss = Boss(
      name: 'Ice Troll',
      respawnInterval: 30,
      icon: 'assets/images/GoldenJuggernaut_icon.png',
    );
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

  @override
  //Cleaning
  void dispose() {
    timer?.cancel(); //stop any timer if present and running
    super.dispose(); //flutter cleanup
  }

  @override
  Widget build(BuildContext context) {
    final timeString =
        timeRemaining == null
            ? ('--:--')
            : ('${timeRemaining!.inMinutes.toString().padLeft(2, '0')}:${timeRemaining!.inSeconds.remainder(60).toString().padLeft(2, '0')}');
    //set time string to be a string value of timeRemaining - if it's null, then display --:--
    startTimer();
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/images/FrostOgre_icon.png'),
          height: 50,
          width: 50,
        ),
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                '${boss.name}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(timeString, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
