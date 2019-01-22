import 'package:flutter/material.dart';
import './views/home.dart';

void main() => runApp(Prezence());

class Prezence extends StatelessWidget {

	static String title = "Prezence";

    @override
    Widget build(BuildContext context) {

        return MaterialApp(
            title: Prezence.title,
            theme: ThemeData(primarySwatch: Colors.blue),
          	home: HomeScreen(title: Prezence.title),
      	);
    }
}