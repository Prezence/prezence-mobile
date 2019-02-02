// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../../services/app-metrics.dart';
import '../../types/meditation-stats.dart';

class AnimatedStatsWidget extends AnimatedWidget {

	AnimatedStatsWidget({ Key key, Animation<Color> animation, MeditationStats stats }) 
		: _stats = stats, super ( key: key, listenable: animation );
	
	final MeditationStats _stats;

	Widget build(BuildContext context) {

		final Animation<Color> animation = listenable;

		final Shadow _shadow = Shadow(
			offset: Offset(1.0, 1.0),
			blurRadius: 2.0,
			color: Color.fromARGB(255, 0, 12, 24),
		);

		final TextStyle _style = Theme.of(context).textTheme.headline
			.copyWith( fontWeight: FontWeight.w200, fontSize: 20.0, shadows: [ _shadow ]);

		return Card(
			margin: EdgeInsets.all(24),
			color: Color.fromARGB(96, 16, 8, 16),
			elevation: 6,
			child: RawMaterialButton(
				onPressed: () {  },
				constraints: BoxConstraints.expand(height: 200),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children : <Widget>[
					
						Text(
							'Total minutes meditated: ' + _stats.totals.totalMinutes.toString(), 
							style: _style.copyWith(color: animation.value)
						)
					]
				)
			)
		);
	}
}

class HomeStats extends StatefulWidget {

	const HomeStats({ Key key }) : super(key: key);

	@override
	HomeStatsState createState() => new HomeStatsState();
}

class HomeStatsState extends State<HomeStats> with SingleTickerProviderStateMixin {

	AnimationController _animationController;

	Animation _colorTween;

	MeditationStats _stats = MeditationStats.empty();

	@override
	void initState() {

		super.initState();
	
		_animationController = AnimationController(vsync: this, duration: Duration(milliseconds:1000));
		_animationController.forward();

		refresh();
	}

	void refresh() async {

		MeditationStats _currentStats = await AppMetrics.getstats();
		setState(() { _stats = _currentStats; });
	}

	@override
	Widget build(BuildContext context) {

		_colorTween = ColorTween(begin: Colors.cyan, end: Colors.white)
			.animate(_animationController)
				..addListener(() { setState(() { }); });

		return AnimatedStatsWidget(animation: _colorTween, stats: _stats);
	}
}