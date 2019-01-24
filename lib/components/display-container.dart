// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';

import '../components/background-video.dart';
import '../components/nav-tab-icon.dart';
import '../types/screen-view.dart';

class DisplayContainer extends StatefulWidget {

    DisplayContainer({ Key key, @required this.title, @required this.screens }) : super(key: key);

    final String title;

	final List<ScreenView> screens;

    @override
    _DisplayContainerState createState() => _DisplayContainerState();
}

class _DisplayContainerState extends State<DisplayContainer> with SingleTickerProviderStateMixin {

	TabController _controller;

	get selected { return _selected; }

	int _selected = 0;

	get animation { return _animation; }

	Animation _animation;

	List<Tab> get _tabs {

		int _index = 0;
		Iterable<Tab> _map = widget.screens.map<Tab>((ScreenView screen) {

			Tab _tab = Tab(
				icon: new NavTabIcon(
					index: _index, 
					icon: screen.icon, 
					animation: _animation
				),
			);

			_index++;
			return _tab;
		});
		
		return _map.toList();
	}

	@override
	void initState() {

		super.initState();
		_controller = new TabController(vsync: this, length: widget.screens.length);
		_animation = _controller.animation;
	}

	@override
	void dispose() {

		super.dispose();
		_controller.dispose();
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(

			body: Stack(

				alignment: AlignmentDirectional.topStart,
				children: <Widget>[
					
					BackgroundVideo(assetName: 'assets/videos/zenstones.mp4'),
					
					TabBarView(
						controller: _controller,
						children: widget.screens.map<Widget>((ScreenView screen) { return screen.widget; }).toList(),
					),

					Column(	
						mainAxisAlignment: MainAxisAlignment.end,
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: [
							
							TabBar(
								labelPadding: EdgeInsets.zero,
								controller: _controller,
								indicatorWeight: 4,
								tabs: _tabs,
								indicatorPadding: EdgeInsets.all(1)
							)
						]
					)
				]	
			)
		);
    }
}