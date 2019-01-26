// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './types/screen-view.dart';
import './components/display-container.dart';
import './views/home.dart';
import './views/meditation-guided.dart';
import './views/meditation-timed.dart';

class Prezence extends StatelessWidget {
	
	static String title = "Prezence";

    @override
    Widget build(BuildContext context) {

		List<ScreenView> _screens = [

			ScreenView(
				name: 'Home',
				widget: HomeScreen(),
				icon: Image.asset('assets/images/icon-home.png')
			),

			ScreenView(
				name: 'Timed Meditation', 
				widget: MeditationTimedScreen(),
				icon: Image.asset('assets/images/icon-meditation-bowl.png')
			),

			ScreenView(
				name: 'Guided Meditation', 
				widget: MeditationGuidedScreen(),
				icon: Image.asset('assets/images/icon-headphones.png')
			),
		
		];

        return MaterialApp(
            title: Prezence.title,
            theme: ThemeData(primarySwatch: Colors.brown),
          	home: DisplayContainer(title: Prezence.title, screens: _screens),
      	);
    }
}

Future<void> main() async {

	await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
	runApp(Prezence());
}