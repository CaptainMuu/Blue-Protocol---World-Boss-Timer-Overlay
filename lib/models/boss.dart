import 'dart:core';

class Boss {
  String name; //name of the boss
  int respawnInterval; //in minutes
  String icon; //icon assets path

  Boss({required this.name, required this.respawnInterval, required this.icon});

  factory Boss.fromJson(Map<String, dynamic> json) {
    return Boss(
      name: json['name'],
      respawnInterval: json['respawnInterval'],
      icon: json['icon'],
    );
  }

  Duration timeUntilNextSpawn() {
    //check what minute of hour it is
    final currentMinute = DateTime.now().minute;
    final currentSecond = DateTime.now().second;
    int minuteToSpawn = 0;
    int secondToSpawn = 60 - currentSecond;
    if (currentMinute < respawnInterval) {
      minuteToSpawn = respawnInterval - currentMinute;
      return Duration(minutes: minuteToSpawn, seconds: secondToSpawn);
    } else {
      minuteToSpawn = currentMinute - respawnInterval;
    }
    return Duration(minutes: minuteToSpawn, seconds: secondToSpawn);
  }
}
