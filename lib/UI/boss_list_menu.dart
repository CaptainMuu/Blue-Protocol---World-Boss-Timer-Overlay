import 'dart:convert';

import 'package:bp_world_boss/models/boss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show rootBundle; //get only rootBundle from this package

class BossListMenu extends StatefulWidget {
  BossListMenu({super.key});

  State<BossListMenu> createState() => _BossListMenuState();
}

class _BossListMenuState extends State<BossListMenu> {
  late Future<List<Boss>> bossesFuture;

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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
