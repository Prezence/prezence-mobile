// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';

class AnimatedSubtitleWidget extends AnimatedWidget {

	AnimatedSubtitleWidget({ Key key, Animation<Color> animation, String text }) 
		: _text = text, super ( key: key, listenable: animation );
	
	final String _text;

	final Shadow _shadow = Shadow(
		offset: Offset(1.0, 1.0),
		blurRadius: 2.0,
		color: Color.fromARGB(255, 0, 12, 24),
	);

	Widget build(BuildContext context) {

		final Animation<Color> _animation = listenable;

		final TextStyle _style = Theme.of(context).textTheme.display1
			.copyWith( fontWeight: FontWeight.w200, shadows: [ _shadow ]);

		return ConstrainedBox(

			constraints: BoxConstraints.expand(height: 200),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children : <Widget>[
					Text(
						_text,
						style: _style.copyWith(color: _animation.value)
					),
				]
			)
		);
	}
}

class SubPageHeader extends StatefulWidget {

	const SubPageHeader({ Key key, @required String text }) : _text = text, super(key: key);

	final String _text;

	@override
	SubPageHeaderState createState() => new SubPageHeaderState();
}

class SubPageHeaderState extends State<SubPageHeader> with SingleTickerProviderStateMixin {

	AnimationController _animationController;
	Animation _colorTween;

	@override
	void initState() {

		super.initState();
	
		_animationController = AnimationController(vsync: this, duration: Duration(milliseconds:800));
		_animationController.forward();
	}

	@override
	Widget build(BuildContext context) {

		_colorTween = ColorTween(begin: Colors.brown, end: Colors.cyan[50])
			.animate(_animationController)
				..addListener(() { setState(() { }); });

		return AnimatedSubtitleWidget(animation: _colorTween, text: widget._text);
	}
}