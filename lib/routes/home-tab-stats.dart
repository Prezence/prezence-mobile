// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../components/widgets/title-header.dart';
import '../components/widgets/home-stats.dart';

class HomeTabStats extends StatelessWidget {

	const HomeTabStats({
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
					child: HomeStats()
				)				
			],
		);
	}
}