import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './views/home.dart';

class Prezence extends StatelessWidget {

	static String title = "Prezence";

    @override
    Widget build(BuildContext context) {

        return MaterialApp(
            title: Prezence.title,
            theme: ThemeData(primarySwatch: Colors.brown),
          	home: HomeScreen(title: Prezence.title),
      	);
    }
}

Future<void> main() async {

	await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
	runApp(Prezence());
}