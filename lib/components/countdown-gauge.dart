// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import '../types/geometry.dart';

class CountdownGauge extends StatelessWidget {

	const CountdownGauge({
		Key key,
		@required Duration duration,
		@required Duration initialDuration
	}) : _duration = duration, _initialDuration = initialDuration, super(key: key);

	final Duration _duration;
	final Duration _initialDuration;

	@override
	Widget build(BuildContext context) {

		int totalMinutes = _duration.inMinutes;
		int totalSeconds = _duration.inSeconds;
		int _hours = (totalMinutes / 60).floor();
		int _minutes = (totalSeconds / 60).floor();
		int _seconds = _minutes > 0 ? (totalSeconds  %  60) : 0;

		Geometry geometry = new Geometry(context);

		double percentComplete = _duration.inSeconds / _initialDuration.inSeconds;

		TextStyle _style = TextStyle(color: Colors.orange[50], fontSize: 32, fontWeight: FontWeight.w200);
		

		return CustomPaint(
			foregroundPainter: new GaugePainter(percentComplete: percentComplete),
			child: ConstrainedBox(

				constraints: BoxConstraints.expand(height: geometry.root, width: geometry.root),
				child: Container(
					//color: Color.fromARGB(128, 0, 0, 0),
					child: Align(
						alignment: Alignment.center,
						child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								Text(_hours.toString().padLeft(2, '0'), style: _style),
								Text(':', style: _style),
								Text(_minutes.toString().padLeft(2, '0'), style: _style),
								Text(':', style: _style),
								Text(_seconds.toString().padLeft(2, '0'), style: _style)
							],
						)
					)
				),
			)
		);	
	}
}

class GaugePainter extends CustomPainter {

	GaugePainter({ @required double percentComplete }) 
	: _percentComplete = percentComplete, super();

	final double _percentComplete;

	@override
	void paint(Canvas canvas, Size size) {

		Paint circleBrush = new Paint()
			..strokeWidth = 2.0
			..color = Colors.indigo[400].withOpacity(0.6)
			..style = PaintingStyle.stroke;

		Paint elapsedBrush = new Paint()
			..strokeWidth = 2.0
			..color = Colors.cyan[50].withOpacity(0.8)
			..style = PaintingStyle.stroke;

		Offset center = new Offset(size.width/2, size.height/2);

		double radius = min(size.width / 2.2, size.height / 2.2);
		
		canvas.drawCircle(center, radius, circleBrush);

		double arcAngle = 2 * pi * ( _percentComplete );

		Rect rect = new Rect.fromCircle(center: center,radius: radius);

		canvas.drawArc(rect, -pi/2, arcAngle, false, elapsedBrush);
	}

	@override
  	bool shouldRepaint(CustomPainter oldDelegate) => true;
}


