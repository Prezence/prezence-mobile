// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:core';
import 'package:flutter/material.dart';
import '../components/subpage-header.dart';
import '../components/smart-button.dart';
import '../components/countdown-gauge.dart';
import '../services/timer-bus.dart';
import '../types/geometry.dart';
import '../types/util.dart';

class TimerCountdownScreen extends StatefulWidget {

	const TimerCountdownScreen({ Key key }) : super(key: key);

	@override
	TimerCountdownScreenState createState() => new TimerCountdownScreenState();
}

class TimerCountdownScreenState extends State<TimerCountdownScreen> {

	@override
	void initState() {

		super.initState();
		TimerBus.registerElapsedListener((TimerElapsedEvent event) {  setState((){ }); });
		TimerBus.registerCompletedListener((TimerCompletedEvent event) { print('completed'); });
		TimerBus.start();
	}

	@override
	void dispose() {

		super.dispose();
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

								setState(() {
								  
								});
							}
						),
						SmartButton(
							text: 'cancel',
							onPressed: () { 
								Navigator.pop(context); 
							}
						)
					]
				)
			]
		);
	}
}