// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../../types/nav-route.dart';
import '../../routes/timer-countdown.dart';
import './background-video.dart';
import './nav-container.dart';

class AppContainer extends StatefulWidget {

    AppContainer({ Key key, @required this.title, @required this.screens }) : super(key: key);

    final String title;
	final List<NavRoute> screens;

    @override
    _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> with SingleTickerProviderStateMixin {

	@override
	void initState() {

		super.initState();
	}

	@override
	void dispose() {

		super.dispose();
	}

	Route<dynamic> _onGenerateRoute(RouteSettings settings) {

		switch (settings.name) {

			case '/timer':
			return MaterialPageRoute( builder: (BuildContext _) => TimerCountdownScreen() );

			case '/':
			default:
			return MaterialPageRoute( builder: (BuildContext _) => NavContainer(children: widget.screens) );
		}
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			body: Stack(

				alignment: AlignmentDirectional.topStart,
				children: <Widget>[
					
					BackgroundVideo(assetName: 'assets/videos/zenstones.mp4'),
					Navigator(onGenerateRoute: _onGenerateRoute)
				]
			)
		);
    }
}