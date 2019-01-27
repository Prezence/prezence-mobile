// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';

class AnimatedStatsWidget extends AnimatedWidget {

	AnimatedStatsWidget({ Key key, Animation<Color> animation }) 
		: super ( key: key, listenable: animation );
	
	Widget build(BuildContext context) {

		final Animation<Color> animation = listenable;

		final Shadow _shadow = Shadow(
			offset: Offset(2.0, 2.0),
			blurRadius: 3.0,
			color: Color.fromARGB(255, 0, 12, 24),
		);

		final TextStyle _style = Theme.of(context).textTheme.display2
			.copyWith( fontWeight: FontWeight.w200, shadows: [ _shadow ]);

		return ConstrainedBox(

			constraints: BoxConstraints.expand(height: 200),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children : <Widget>[
				
					Text(
						'Total minutes meditated: ' , 
						style: _style.copyWith(color: animation.value)
					)
				]
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

	@override
	void initState() {

		super.initState();
	
		_animationController = AnimationController(vsync: this, duration: Duration(milliseconds:1000));
		_animationController.forward();
	}

	@override
	Widget build(BuildContext context) {

		_colorTween = ColorTween(begin: Colors.cyan, end: Colors.orange[50])
			.animate(_animationController)
				..addListener(() { setState(() { }); });

		return AnimatedStatsWidget(animation: _colorTween);
	}
}