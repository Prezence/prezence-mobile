// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'package:flutter/material.dart';
import '../../types/nav-route.dart';
import './nav-route-view.dart';
import './nav-tab-icon.dart';
import '../../services/animation-bus.dart';

class NavContainer extends StatefulWidget {

    NavContainer({ Key key, @required this.children }) : super(key: key);

	final List<NavRoute> children;

    @override
    _NavContainerState createState() => _NavContainerState();
}

class _NavContainerState extends State<NavContainer> with SingleTickerProviderStateMixin {

	TabController _controller;

	get animation { return _animation; }
	Animation _animation;

	List<Tab> get _tabs {

		int _index = 0;
		Iterable<Tab> _map = widget.children.map<Tab>((NavRoute screen) {

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

	List<NavRouteView> get _routes {

		int _index = 0;
		Iterable<NavRouteView> _map = widget.children.map<NavRouteView>((NavRoute screen) { 

			NavRouteView _view = NavRouteView(
				index: _index, 
				child: screen.widget, 
				animation: _animation
			);

			_index++;
			return _view;
		});
		
		return _map.toList();
	}

	@override
	void initState() {

		super.initState();

		_controller = new TabController(vsync: this, length: widget.children.length);
		_animation = _controller.animation;
		AnimationBus.registerTabController(_controller);
	}

	@override
	void dispose() {

		super.dispose();
		_controller.dispose();
	}

	@override
	Widget build(BuildContext context) {

		return Stack(
			children: <Widget> [

				Container(
					padding: EdgeInsets.only(bottom: 48),
					constraints: BoxConstraints.expand(),
					child: TabBarView(
						controller: _controller,
						children: _routes
					),
				),

				Column(	
					mainAxisAlignment: MainAxisAlignment.end,
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						
						( Platform.isAndroid )
						
						? TabBar(
							indicatorPadding: EdgeInsets.all(1),
							labelPadding: EdgeInsets.zero,
							controller: _controller,
							indicatorWeight: 4,
							tabs: _tabs
						)

						: TabBar(
							indicator: BoxDecoration(),
							labelPadding: EdgeInsets.zero,
							controller: _controller,
							tabs: _tabs
						)
					]
				)
			]
		);
	}
}