// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../../services/app-metrics.dart';
import '../../types/meditation-stats.dart';
import '../../types/utc-timestamp.dart';

class HistoryCard extends StatefulWidget {

	const HistoryCard({ 
		Key key,
		@required this.stats,
		this.onPressed 
	}) : super(key: key);

	@override
	HistoryCardState createState() => new HistoryCardState();

	final MeditationStats stats;
	final Function onPressed;
}

class HistoryCardState extends State<HistoryCard> with SingleTickerProviderStateMixin {

	AnimationController _animationController;
	Animation _colorTween;
	
	@override
	void initState() {

		super.initState();
		_animationController = AnimationController(vsync: this, duration: Duration(milliseconds:400));
		_animationController.forward();
	}

	@override
	void dispose() {

		_animationController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {

		_colorTween = ColorTween(begin: Colors.black26, end: Colors.blueGrey[50])
			.animate(_animationController)
				..addListener(() { setState(() { }); });

		return AnimatedCardWidget(
			animation: _colorTween, 
			stats: widget.stats,
			onPressed: widget.onPressed
		);
	}
}


class AnimatedCardWidget extends AnimatedWidget {

	AnimatedCardWidget({ 
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

		String _base = "Last Session: ";
		DateTime then = session.dateTime;
		DateTime now = DateTime.now();

		if (now.difference(then) > Duration(days: 2)) {
			return _base + then.toLocal().toString().split(' ')[0];
		}
		else if (now.difference(then) > Duration(days: 1)) {
			return _base + "Yesterday"; //+ then.toLocal().toString().split(' ')[1];
		}
		else if (now.difference(then) > Duration(hours: 1)) {		
			return _base + now.difference(then).inHours.toString() + " hours ago";  // + then.toLocal().toString().split(' ')[1];
		}
		else if (now.difference(then) > Duration(minutes: 1)) {
			return _base + now.difference(then).inMinutes.toString() + " minutes ago";
		}
		else {
			return _base + now.difference(then).inSeconds.toString() + " seconds ago";
		}
	}

	get totalMinutesString {
		
		if (_stats.totals.totalMinutes == null) { return "No meditation history."; }
		return "Running Total: " + _stats.totals.totalTimeString;
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
				fontSize: 16.0
			);

		return Card(
			
			margin: EdgeInsets.all(0),
			color: Colors.black38,
			elevation: 6,
			child: Container(
				padding: EdgeInsets.all(0),
				margin: EdgeInsets.all(0),
				decoration: BoxDecoration(
					border: Border.all(color: Colors.black26)
				),
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
									top: 12,
									bottom: 12,								
									left: 32
								),
								child: Text(
									totalMinutesString,
									style: _style.copyWith(color: animation.value)
								),
							),
							Container(
								padding: EdgeInsets.only(								
									bottom: 48,
									left: 32
								),
								child: Text(
									lastSessionString, 
									style: _style.copyWith(color: animation.value)
								),
							)
						]
					)
				),
			)
		);
	}
}
