// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:math';
import 'package:flutter/material.dart';
import '../types/geometry.dart';

class CountdownGauge extends StatefulWidget {

	const CountdownGauge({
		Key key,
		@required Duration duration,
		@required Duration initialDuration
	}) : _duration = duration, _initialDuration = initialDuration, super(key: key);

	final Duration _duration;
	final Duration _initialDuration;

	@override
	CountdownGaugeState createState() { return new CountdownGaugeState(); }
}

class CountdownGaugeState extends State<CountdownGauge> with SingleTickerProviderStateMixin {

	AnimationController _animationController;
	Animation _animation;
	double _opacity = 0.0;

	@override
	void initState() {

		super.initState();
		// setState(() { _opacity = 1.0; });
	
		_animationController = AnimationController(vsync: this, duration: Duration(milliseconds:600));
		_animationController.forward();
	}

	@override
	void dispose() {
		super.dispose();
		_animationController = AnimationController(vsync: this, duration: Duration(milliseconds:100));
		_animationController.reverse();
	}

	@override
	Widget build(BuildContext context) {

		// int totalMinutes = widget._duration.inMinutes;
		int totalSeconds = widget._duration.inSeconds;
		int _hours =  widget._duration.inHours;
		int _minutes = ((totalSeconds / 60) - _hours * 60).floor();
		int _seconds =  (totalSeconds  %  60);

		Geometry _geometry = new Geometry(context);
		double _percentComplete = widget._duration.inSeconds / widget._initialDuration.inSeconds;
		
		_animation = Tween(begin: 0.0, end: 1.0)
			.animate(_animationController)
				..addListener(() { setState(() { }); });

		return new AnimatedGaugeWidget(
			percentComplete: _percentComplete, 
			geometry: _geometry, 
			hours: _hours, 
			minutes: _minutes, 
			seconds: _seconds,
			animation: _animation,
		);
	}
}

class AnimatedGaugeWidget extends AnimatedWidget {

	const AnimatedGaugeWidget({
		Key key,
		@required double percentComplete,
		@required Geometry geometry,
		@required int hours,
		@required int minutes,
		@required int seconds,
		Animation<double> animation
	}) : _percentComplete = percentComplete, _geometry = geometry, _hours = hours, _minutes = minutes, _seconds = seconds, super(key: key, listenable: animation);

  	final double _percentComplete;
	final Geometry _geometry;
	final int _hours;
	final int _minutes;
	final int _seconds;

	@override
	Widget build(BuildContext context) {

		final Animation<double> _animation = listenable;
		final double _opacity = _animation.value;

		TextStyle _style = TextStyle(
			color: Colors.orange[50].withOpacity(_opacity), 
			fontSize: 32, 
			fontWeight: FontWeight.w200,
			
		);
		
		return CustomPaint(
				
			foregroundPainter: new GaugePainter(percentComplete: _percentComplete, opacity: _opacity),
			child: Container(

				constraints: BoxConstraints.expand(height: _geometry.root, width: _geometry.root),
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
						]
					)
				)
			)
		);
	}
}

class GaugePainter extends CustomPainter {

	GaugePainter({ @required double percentComplete, @required double opacity }) 
		: _percentComplete = percentComplete, _opacity = opacity, super();

	final double _percentComplete;
	final double _opacity;

	@override
	void paint(Canvas canvas, Size size) {

		Paint circleBrush = new Paint()
			..strokeWidth = 2.0
			..color = Colors.indigo[400].withOpacity(0.6 * _opacity )
			..style = PaintingStyle.stroke;

		Paint elapsedBrush = new Paint()
			..strokeWidth = 2.0
			..color = Colors.cyan[50].withOpacity(0.8 * _opacity)
			..style = PaintingStyle.stroke;

		Offset center = new Offset(size.width/2, size.height/2);
		double radius = min(size.width / 2.2, size.height / 2.2);
		Rect rect = new Rect.fromCircle(center: center,radius: radius);
		double angle = 2 * pi * ( _percentComplete );

		canvas.drawCircle(center, radius, circleBrush);
		canvas.drawArc(rect, -pi/2, angle, false, elapsedBrush);
	}

	@override
  	bool shouldRepaint(CustomPainter oldDelegate) => true;
}