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
    final now = DateTime.now();
    DateTime nextRespawn = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      respawnInterval,
    );
    if (now.isAfter(nextRespawn)) {
      nextRespawn = nextRespawn.add(Duration(hours: 1)); //add hour
    }
    return nextRespawn.difference(now);
  }
}
