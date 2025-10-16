import 'dart:convert';
import 'dart:io';

import 'package:bp_world_boss/models/boss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show rootBundle; //get only rootBundle from this package

class BossListMenu extends StatefulWidget {
  BossListMenu({super.key});

  State<BossListMenu> createState() => _BossListMenuState();
}

class _BossListMenuState extends State<BossListMenu> {
  late Future<List<Boss>> bossesFuture;

  void openBossOverlay(String bossName) async {
    final exePath = Platform.resolvedExecutable;
    print(exePath);
    try {
      final process = await Process.start(exePath, [
        bossName,
      ], runInShell: true);
      process.stdout.transform(utf8.decoder).listen((data) {
        print('[overlay stdout]: $data');
      });
      process.stderr.transform(utf8.decoder).listen((data) {
        print('[overlay stdout]: $data');
      });
    } catch (e) {
      print('error');
    }
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
          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.png'),
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: bosses.length,
              itemBuilder: (BuildContext context, int index) {
                return DefaultTextStyle(
                  style: TextStyle(
                    fontFamily: 'Nordic',
                    fontSize: 40,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 1.0),
                        blurRadius: 1.0,
                        color: Color.fromARGB(255, 155, 0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(),
                          child: Text(bosses[index].name.replaceAll('_', ' ')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ElevatedButton(
                            onPressed:
                                () => openBossOverlay(bosses[index].name),
                            child: Text(
                              "Display",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
