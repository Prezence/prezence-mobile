// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'package:flutter/material.dart';

class NavTabIcon extends StatefulWidget {

	const NavTabIcon({
		Key key,
		@required Image icon,
		@required int index,
		@required Animation animation
	}) : _icon = icon, _index = index, _animation = animation, super(key: key);

	final Image _icon;
	final int  _index;
	final Animation _animation;

	@override
	NavTabIconState createState() =>  new NavTabIconState();
}

class NavTabIconState extends State<NavTabIcon> {

	@override
	Widget build(BuildContext context) {

		return AnimatedBuilder(
			animation: widget._animation,
			child: widget._icon,
			builder: (BuildContext context, Widget child) {
				
				int index = widget._index;
				double value = widget._animation.value;
				double delta = value - index + 1;

				double opacity = (delta >= 0.0 && delta <= 1.0) 
					? delta
					: (delta > 1 && delta < 2) ? (2 - delta) : 0;

				if (opacity > 0.84) { opacity = 0.84; }
				if (opacity < 0.26) { opacity = 0.26; }

				return Container(
					constraints: BoxConstraints.expand(),					
					child: Padding(
						padding: Platform.isAndroid 
							? EdgeInsets.only(bottom: 4, top: 8)
							: EdgeInsets.only(bottom: 12),
						child: Opacity(
							opacity: opacity,
							child: widget._icon
						)
					)
				);
			}
		);
	}
}