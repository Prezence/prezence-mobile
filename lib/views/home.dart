// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:core';
import 'package:flutter/material.dart';
import '../components/title-header.dart';

class HomeScreen extends StatelessWidget {

	const HomeScreen({
		Key key,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		Size _deviceSize = MediaQuery.of(context).size;

		double _padding = 0.0;
		double _width = _deviceSize.width * .90;

		Size _navItemSize = Size(_width + _padding, (_width + _padding) / 1.618);

		return Column(

			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[

				TitleHeader(),
				
				ConstrainedBox(
					constraints: BoxConstraints.expand(height: _navItemSize.height),
					child: Container()
				)				
			],
		);
	}

}