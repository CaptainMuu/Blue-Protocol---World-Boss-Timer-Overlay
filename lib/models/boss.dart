import 'dart:core';

class Boss {
  String name; //name of the boss
  int respawnInterval; //in minutes
  Boss({required this.name, required this.respawnInterval});

  Duration timeUntilNextSpawn() {
    //check what minute of hour it is
    final current_minute = DateTime.now().minute;
    final current_second = DateTime.now().second;
    int minuteToSpawn = 0;
    int secondToSpawn = 60 - current_second;
    if (current_minute < respawnInterval) {
      minuteToSpawn = respawnInterval - current_minute;
      return Duration(minutes: minuteToSpawn, seconds: secondToSpawn);
    } else {
      minuteToSpawn = current_minute - respawnInterval;
    }
    return Duration(minutes: minuteToSpawn, seconds: secondToSpawn);
  }
}
