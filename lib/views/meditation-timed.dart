// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:core';
import 'package:flutter/material.dart';
import '../components/subpage-header.dart';
import '../components/smart-button.dart';
import '../services/timer-bus.dart';
import '../types/geometry.dart';
import '../types/util.dart';

class MeditationTimedScreen extends StatefulWidget {

	const MeditationTimedScreen({ Key key }) : super(key: key);

	@override
	MeditationTimedScreenState createState() => new MeditationTimedScreenState();
}

class MeditationTimedScreenState extends State<MeditationTimedScreen> {

	void _onPressStart() {

		TimerBus.init(_duration);
		Navigator.pushNamed(context, '/timer'); 
	}

	Duration _duration = Duration(minutes: 20);

	void _onChangeDuration(Duration duration) {

		_duration = duration;
		setState(() {  });
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

				Container(constraints: BoxConstraints.expand(height: geometry.rootThird)),

				SubPageHeader(text: 'Set Timer'),

				Container(constraints: BoxConstraints.expand(height: geometry.rootQuarter)),

				_durationPicker,

				ButtonGroup(
					buttons: [
						SmartButton(
							text: 'start',
							onPressed: _duration.inMinutes > 0 ? _onPressStart : null
						)
					]
				)
			]
		);
	}
}


class DurationPicker extends StatefulWidget {

	const DurationPicker({
		Key key,
		Function onChange,
		@required Duration duration,
		@required double rootSize
	}) : _root = rootSize, _duration = duration, _onChange = onChange, super(key: key);

	final double _root;
	final Duration _duration;
	final Function _onChange;

	static double clipFactor = 0.82;
	static double itemExtent = 56.0;
	static double diameterRatio = 2.0;

	@override
	DurationPickerState createState() => new DurationPickerState();
}

class DurationPickerState extends State<DurationPicker> {

	FixedExtentScrollController _scrollController1;
	FixedExtentScrollController _scrollController2;

	List<Widget> get _hourItems {

		Iterable<int> range = Util.range(0, 10);
		Iterable<Widget> _widgets = range.map((i) {

			return new TimePickerCard(index: i, listenable: _scrollController1);
		});
		
		return _widgets.toList();
	}

	List<Widget> get _minuteItems {

		Iterable<int> range = Util.range(0, 60);
		Iterable<Widget> _widgets = range.map((i) {

			return new TimePickerCard(index: i, listenable: _scrollController2);
		});
		
		return _widgets.toList();
	}

	Duration get duration => Duration(hours: _hours, minutes: _minutes);

	int _hours;
	int _minutes;

	@override
	void initState() {

		super.initState();

		int totalMinutes = widget._duration.inMinutes;
		_hours = (totalMinutes / 60).floor();
		_minutes = (totalMinutes % 60);

		_scrollController1 = new FixedExtentScrollController(initialItem: _hours);
		_scrollController2 = new FixedExtentScrollController(initialItem: _minutes);
	}

	void _onChangeHours(int) {

		_hours = int;
		widget._onChange(duration);
	}

	void _onChangeMinutes(int) {
		
		_minutes = int;
		widget._onChange(duration);
	}

	void _onChange() {

	}

	@override
	Widget build(BuildContext context) {

		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[

				new DurationPickerComponent(
					parent: widget, 
					controller: _scrollController1,
					items: _hourItems,
					onChange: _onChangeHours,
					alignment: Alignment.topLeft
				),

				new DurationPickerComponent(
					parent: widget, 
					controller: _scrollController2,
					items: _minuteItems,
					onChange: _onChangeMinutes,
					alignment: Alignment.topRight
				)
			]
		);
	}
}

class DurationPickerComponent extends StatelessWidget {

	const DurationPickerComponent({
		Key key,
		@required this.parent,
		@required this.onChange,
		@required this.alignment,
		@required FixedExtentScrollController controller,
		@required List<Widget> items,
	}) : _controller = controller, _items = items, super(key: key);

	final DurationPicker parent;
	final Function onChange;
	final Alignment alignment;
	final FixedExtentScrollController _controller;
	final List<Widget> _items;

	@override
	Widget build(BuildContext context) {

		return Padding(

			padding: const EdgeInsets.only(left: 4.0, right: 4.0),
			child: ClipRRect(

				borderRadius: BorderRadius.all(Radius.circular(4.0)),
				child: Align(

					widthFactor: DurationPicker.clipFactor, 
					alignment: alignment,
					child: ConstrainedBox(

						constraints: BoxConstraints.expand(
							height: (parent._root * 0.92), 
							width: (parent._root * 0.76) 
						),

						child: ListWheelScrollView(
							controller: _controller,
							children: _items,
							physics: FixedExtentScrollPhysics(),
							itemExtent: DurationPicker.itemExtent,
							diameterRatio: DurationPicker.diameterRatio,
							onSelectedItemChanged: onChange
						),
					)
				)
			),
		);
  	}
}

class TimePickerCard extends AnimatedWidget {

	const TimePickerCard({
		Key key, @required int index, @required FixedExtentScrollController listenable
	}) : _index = index, super(key: key, listenable: listenable);

	final int _index;

	int get selectedItem {

		final FixedExtentScrollController controller = listenable;
			
		try { return controller.selectedItem; }
		catch (e) { return controller.initialItem; }
	}

	double get itemOpacity {

		int _selectedItem = selectedItem;

		if (_selectedItem == _index) { return 0.88; }
		if ((_selectedItem - 1 == _index || _selectedItem + 1 == _index)) { return 0.4; }
		return 0.2;
	}

	double get cardOpacity {

		int _selectedItem = selectedItem;

		if (_selectedItem == _index) { return 0.54; }
		if ((_selectedItem - 1 == _index || _selectedItem + 1 == _index)) { return 0.48; }
		return 0.24;
	}

	@override
	Widget build(BuildContext context) {				

		return Card(
			color: Colors.black.withOpacity(cardOpacity),
			child: Row(

				children: <Widget>[
					
					Expanded(
						child: Row(

							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[

								Text(
									_index.toString(),
									style: TextStyle(
										color: Colors.orange[50].withOpacity(itemOpacity),
										fontSize: 22,
										fontWeight: FontWeight.w300
									)
								)
							]
						)
					)
				]
			)
		);
	}
}