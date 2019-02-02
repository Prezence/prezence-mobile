// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../components/widgets/smart-button.dart';
import '../components/widgets/countdown-gauge.dart';
import '../services/timer-bus.dart';
import '../services/media-bus.dart';
import '../services/app-metrics.dart';
import '../types/geometry.dart';

class TimerCountdownScreen extends StatefulWidget {

	const TimerCountdownScreen({ Key key }) : super(key: key);

	@override
	TimerCountdownScreenState createState() => new TimerCountdownScreenState();
}

class TimerCountdownScreenState extends State<TimerCountdownScreen> with SingleTickerProviderStateMixin {

	@override
	void initState() {

		super.initState();

		TimerBus.registerElapsedListener(_onTimerElapsed);
		TimerBus.registerCompletedListener(_onTimerComplete);

		TimerBus.start();

		try { MediaBus.playSoundEffect('bell-strike-1.mp3'); }
		catch(ex) { print(ex); }
	}

	@override
	void dispose() {

		super.dispose();
	}

	void _onTimerElapsed(TimerElapsedEvent event) {

		if (mounted) { return setState(() { }); }
	}

	void _onTimerComplete(TimerCompletedEvent event) {

		if (mounted) {

			AppMetrics.logSession(TimerBus.initialDuration);
			
			MediaBus.playSoundEffect('bell-strike-2.mp3');
			
			Navigator.popUntil(context, (Route route) => route.isFirst);
		}
	}

	@override
	Widget build(BuildContext context) {

		Geometry geometry = new Geometry(context);

		return Column(

			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[

				Container(constraints: BoxConstraints.expand(height: geometry.rootQuarter)),

				CountdownGauge(initialDuration: TimerBus.initialDuration, duration: TimerBus.duration),

				Container(constraints: BoxConstraints.expand(height: geometry.rootEighth)),
				
				ButtonGroup(
					buttons: [

						SmartButton(
							text: TimerBus.isRunning ? 'pause' : 'resume',
							onPressed: () {

								TimerBus.isRunning 
								 	? TimerBus.stop() 
									: TimerBus.start();

								setState(() { });
							}
						),
						SmartButton(
							text: 'cancel',
							onPressed: () {

								TimerBus.clear();
								Navigator.pop(context); 
							}
						)
					]
				)
			]
		);
	}
}