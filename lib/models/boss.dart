class Boss {
  String name; //name of the boss
  Duration respawnInterval; //60 or 30 minutes
  DateTime currentTime = DateTime.now(); //current time

  Boss({required this.name, required this.respawnInterval});

  Duration timeUntilNextSpawn() {
    //check what minute of hour it is
    final current_minute = DateTime.now().minute;
    print(current_minute);
    int timeToSpawn = 0;
    int duration = respawnInterval.inMinutes;
    switch (respawnInterval) {
      case const Duration(minutes: 30):
        if (current_minute < duration) {
          timeToSpawn = duration - current_minute;
          return Duration(minutes: timeToSpawn);
        } else {
          timeToSpawn = current_minute - duration;
        }
        break;
      case const Duration(minutes: 60):
        if (current_minute < duration) {
          timeToSpawn = duration - current_minute;
          return Duration(minutes: timeToSpawn);
        } else {
          timeToSpawn = current_minute - duration;
        }
        break;
    }
    return Duration(minutes: timeToSpawn);
  }
}
