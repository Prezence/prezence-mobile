// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../../services/app-metrics.dart';
import '../../types/meditation-stats.dart';
import '../../services/navigation-bus.dart';
import '../../types/utc-timestamp.dart';

class AnimatedStatsWidget extends AnimatedWidget {

	AnimatedStatsWidget({ 
		Key key, 
		Animation<Color> animation, 
		MeditationStats stats,
		Function onPressed
	}) 
	: _stats = stats, _onPressed = onPressed, super ( key: key, listenable: animation );
	
	final MeditationStats _stats;
	final Function _onPressed;

	get lastSessionString {

		UTCTimestamp session = _stats.lastSession;

		if (session == null) { 
			return "Click here to start!";
		}

		String _base = "Last session: ";
		DateTime then = session.dateTime;
		DateTime now = DateTime.now();

		if (then.difference(now) > Duration(days: 2)) {
			return _base + then.toLocal().toString().split(' ')[0];
		}
		else if (then.difference(now) > Duration(days: 1)) {
			return _base + "Yesterday"; //+ then.toLocal().toString().split(' ')[1];
		}
		else {
			return _base + "Today"; // + then.toLocal().toString().split(' ')[1];
		}
	}

	get totalMinutesString {
		
		return (_stats.totals.totalMinutes == null)
			? "No meditation history."
			: 'Minutes meditated: ' +  _stats.totals.totalMinutes.toString();
	}

	Widget build(BuildContext context) {

		final Animation<Color> animation = listenable;

		final Shadow _shadow = Shadow(
			offset: Offset(1.0, 1.0),
			blurRadius: 2.0,
			color: Color.fromARGB(255, 0, 12, 24),
		);

		final TextStyle _headerStyle = Theme.of(context).textTheme.headline
			.copyWith( 
				fontWeight: FontWeight.w100, 
				fontSize: 20.0, 
				shadows: [ _shadow ]
			);

		final TextStyle _style = Theme.of(context).textTheme.headline
			.copyWith(			
				fontWeight: FontWeight.w200,
				shadows: [ _shadow ],
				fontSize: 18.0
			);

		return Card(
			
			margin: EdgeInsets.all(24),
			color: Colors.black38,
			elevation: 6,
			child: RawMaterialButton(
				
				//padding: EdgeInsets.all(16),
				onPressed: _onPressed,
				child: Column(

					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: <Widget>[
						
						Container(							
							padding: EdgeInsets.only(
								top: 12,
								bottom: 12,
								left: 16
							),
							decoration: BoxDecoration(
								color: Colors.black45,
								border: Border(
									bottom: BorderSide(
										color: Colors.grey[600]
									)
								)
							),
							child: Text(
								'History',
								style: _headerStyle.copyWith(color: animation.value)
							),
						),
						Container(
							padding: EdgeInsets.only(
								top: 16,
								bottom: 12,
								left: 24
							),
						  	child: Text(
							  	totalMinutesString,
							  	style: _style.copyWith(color: animation.value)
							),
						),
						Container(
							padding: EdgeInsets.only(
								top: 8,
								bottom: 24,
								left: 24
							),
							child: Text(
								lastSessionString, 
								style: _style.copyWith(color: animation.value)
							),
						)
					]
				)
			)
		);
	}
}

class HistoryCard extends StatefulWidget {

	const HistoryCard({ Key key }) : super(key: key);

	@override
	HistoryCardState createState() => new HistoryCardState();
}

class HistoryCardState extends State<HistoryCard> with SingleTickerProviderStateMixin {

	AnimationController _animationController;

	Animation _colorTween;

	MeditationStats _stats = MeditationStats.empty();

	@override
	void initState() {

		super.initState();
	
		_animationController = AnimationController(vsync: this, duration: Duration(milliseconds:400));
		_animationController.forward();

		refresh();
	}

	@override
	void dispose() {

		_animationController.dispose();
		super.dispose();
	}

	void refresh() async {

		_stats = await AppMetrics.getStats();
		setState(() {  });
	}

	void _onPressed() {

		if (_stats.lastSession == null) {
			NavigationBus.navigateTo('/set-timer');
		}
		// AppStorage.test().then(setState);
	}

	@override
	Widget build(BuildContext context) {

		_colorTween = ColorTween(begin: Colors.black26, end: Colors.blueGrey[50])
			.animate(_animationController)
				..addListener(() { setState(() { }); });

		return AnimatedStatsWidget(
			animation: _colorTween, 
			stats: _stats,
			onPressed: _onPressed
		);
	}
}