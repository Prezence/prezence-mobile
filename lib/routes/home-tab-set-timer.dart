// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../components/widgets/subpage-header.dart';
import '../components/widgets/smart-button.dart';
import '../components/widgets/duration-picker.dart';
import '../services/timer-bus.dart';
import '../types/geometry.dart';

class HomeTabSetTimer extends StatefulWidget {

	const HomeTabSetTimer({ Key key }) : super(key: key);

	@override
	HomeTabSetTimerState createState() => new HomeTabSetTimerState();
}

class HomeTabSetTimerState extends State<HomeTabSetTimer> {

	Duration _duration = Duration(minutes: 20);

	void _onChangeDuration(Duration duration) {

		_duration = duration;
		setState(() {  });
	}

	void _onPressStart() {

		TimerBus.init(_duration);
		Navigator.pushNamed(context, '/timer'); 
	}

	@override
	Widget build(BuildContext context) {

		Geometry geometry = new Geometry(context);

		DurationPicker _durationPicker = DurationPicker(
			rootSize: geometry.root,
			duration: _duration,
			onChange: _onChangeDuration,
		);

		return Column(

			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[

				SubPageHeader(text: 'Set Timer'),

				Container(constraints: BoxConstraints.expand(height: geometry.rootQuarter)),
				
				Padding(
					padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
					child: _durationPicker,
				),

				Padding(
					padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
					child: ButtonGroup(
						buttons: [
							SmartButton(
								text: 'start',
								onPressed: _duration.inMinutes > 0 ? _onPressStart : null
							)
						]
					),
				)
			]
		);
	}
}