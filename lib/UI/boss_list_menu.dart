import 'dart:convert';
import 'dart:io';

import 'package:bp_world_boss/models/boss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show rootBundle; //get only rootBundle from this package
import 'package:path/path.dart' as path;

class BossListMenu extends StatefulWidget {
  BossListMenu({super.key});

  State<BossListMenu> createState() => _BossListMenuState();
}

class _BossListMenuState extends State<BossListMenu> {
  late Future<List<Boss>> bossesFuture;

  void openBossOverlay(String bossName) async {
    final exePath = path.join(
      'C:/Users/JanRawa/IdeaProjects/bp_world_boss/build/windows/x64/runner/Release',
      'bp_world_boss.exe',
    ); //in final -> path.join(Directory.current.path
    print(exePath);
    await Process.start(exePath, [bossName], runInShell: true);
    print("go");
  }

  Future<List<Boss>> loadBossList() async {
    final data = await rootBundle.loadString(
      'assets/data/bosses.json',
    ); //load json from assets
    final List<dynamic> jsonResults = jsonDecode(data); // decode json to list
    return jsonResults
        .map((element) => Boss.fromJson(element))
        .toList(); //map each element on jsonResults and use a function then make a normal list
  }

  @override
  void initState() {
    super.initState();
    bossesFuture = loadBossList();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Boss>>(
      future: bossesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("error when loading Bossess list ${snapshot.error}"),
          );
        } else {
          final bosses = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: bosses.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Text(
                    bosses[index].name,
                    style: TextStyle(fontFamily: 'Nordic'),
                  ),
                  ElevatedButton(
                    onPressed: () => openBossOverlay(bosses[index].name),
                    child: Text("Display"),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
