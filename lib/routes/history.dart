// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../components/widgets/subpage-header.dart';
import '../components/widgets/smart-button.dart';
import '../models/history-item.dart';
import '../services/app-metrics.dart';

class HistoryScreen extends StatelessWidget {

	const HistoryScreen({
		Key key,
	}) : super(key: key);

	onPressClear(BuildContext parentContext) {

		Future<bool> result = showDialog(
			context: parentContext,
			builder: (BuildContext context) {

				return AlertDialog(
					title: Text('Really clear history?'),
					actions: <Widget>[

						FlatButton(
							child: Text('OK'),
							onPressed: () { Navigator.pop(context, true); },
						),
						FlatButton(
							child: Text('Cancel'),
							onPressed: () { Navigator.pop(context, false); },
						),
					],
				);
			}
		);

		result.then((bool clear) async {

			if (!clear) { return; }
			await AppMetrics.clear();
			Navigator.pop(parentContext, clear);
		});
	}

	@override
	Widget build(BuildContext context) {
				
		return Column(

			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				
				SubPageHeader(text: 'History'),

				new HistoryList(),

				Padding(
					padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
					child: ButtonGroup(
						buttons: [
							SmartButton(
								text: 'clear',
								onPressed: () { onPressClear(context); }
							),
							SmartButton(
								text: 'back',
								onPressed: () { Navigator.pop(context); }
							)
						]
					),
				)
			]
		);
	}
}

class HistoryList extends StatefulWidget {

	const HistoryList({
		Key key,
	}) : super(key: key);

	@override
	HistoryListState createState() => new HistoryListState();
}

class HistoryListState extends State<HistoryList> {

	final BoxShadow _shadow = BoxShadow(
		offset: Offset(1.0, 1.0),
		blurRadius: 2.0,
		color: Color.fromARGB(255, 0, 12, 24),
	);

	final TextStyle _style = TextStyle(color: Colors.white70); 

	List<HistoryItem> _items = [];

	List<Card> get _cards {

		Iterable<Card> _iterable = _items.map((HistoryItem _item) {

			List<String> _parts = _item.eventTimestamp.dateTime.toLocal().toString().split(' ');
			String time = _parts[1].split('.')[0].substring(0, 5);

			String _line1 =  _parts[0] + ' ' + time;
			String _line2 =  _item.minutes.toString() + (_item.minutes > 1 ? ' minutes' : ' minute');
			
			return Card(

				color: Colors.black26, 
				child: Container(

					padding: EdgeInsets.all(12.0),
					constraints: BoxConstraints.expand(height: 72),
					child: Column(

						mainAxisAlignment: MainAxisAlignment.spaceAround,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[

							Text(_line1, style: _style),
							Text(_line2, style: _style)
						],
					),
				)
			);
		});

		return _iterable.toList();
	}

	Future<void> refresh() async {

		_items = await AppMetrics.getHistory();
		setState(() { });
	}

	@override
	initState() {
		
		super.initState();
		refresh();
	}

	@override
	Widget build(BuildContext context) {
		
		return Expanded(

			child: Container(
				decoration: BoxDecoration(
					// border: Border.all(color: Colors.black26),
					color: Colors.black12
				),
				margin: const EdgeInsets.all(8.0).copyWith(bottom: 32.0),
				child: ListView(
					children: _cards
				),
			)
		);
	}
}