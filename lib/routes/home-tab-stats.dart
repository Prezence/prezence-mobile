// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../components/widgets/title-header.dart';
import '../components/widgets/history-card.dart';
import '../services/navigation-bus.dart';
import '../services/app-metrics.dart';
import '../types/meditation-stats.dart';

class HomeTabStats extends StatefulWidget {

	const HomeTabStats({
		Key key,
	}) : super(key: key);

	@override
	HomeTabStatsState createState() => new HomeTabStatsState();
}

class HomeTabStatsState extends State<HomeTabStats> {

	MeditationStats _stats = MeditationStats.empty();

	Future<void> onPressHistory(context) async {

		await NavigationBus.navigateTo(
			context: context, 
			route: _stats.lastSession == null ? '/set-timer' : '/history'
		);

		refresh();
	}
	
	void refresh() async {

		try {
			_stats = await AppMetrics.getStats();
			setState(() { });
		}
		catch(ex) { }
	}

	@override
	void initState() {

		refresh();
    	super.initState();		
  	}

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
				
				Padding(
					padding: EdgeInsets.only(						
						left: 12,
						right: 12,
						bottom: 16
					),
					child: ConstrainedBox(					
						constraints: BoxConstraints.expand(height: _navItemSize.height),
						child: HistoryCard(
							stats: _stats,
							onPressed: () { onPressHistory(context); },
						)
					)				
				)
			],
		);
	}
}