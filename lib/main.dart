// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './services/service-bus.dart';
import './types/nav-route.dart';
import './components/layout/app-container.dart';
import './routes/home-tab-library.dart';
import './routes/home-tab-set-timer.dart';
import './routes/home-tab-stats.dart';

class Prezence extends StatelessWidget {
	
	static String title = "Prezence";

    @override
    Widget build(BuildContext context) {

		List<NavRoute> _screens = [

			NavRoute(
				name: 'Home',
				widget: HomeTabStats(),
				icon: Image.asset('assets/images/icon-home.png')
			),

			NavRoute(
				name: 'Timed Meditation', 
				widget: HomeTabSetTimer(),
				icon: Image.asset('assets/images/icon-meditation-bowl.png')
			),

			NavRoute(
				name: 'Guided Meditation', 
				widget: HomeTabLibrary(),
				icon: Image.asset('assets/images/icon-headphones.png')
			),
		
		];

        return MaterialApp(
            title: Prezence.title,
            theme: ThemeData(primarySwatch: Colors.brown),
          	home: AppContainer(title: Prezence.title, screens: _screens),
      	);
    }
}

Future<void> main() async {

	await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
	await ServiceBus.init();
	runApp(Prezence());
}