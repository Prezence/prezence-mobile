// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';


class TabAnimationEvent { }
class AppNavEvent { AppNavEvent(this.route); String route; }

abstract class NavigationBus { 

	static EventBus _bus = new EventBus();

	static set (TabController x) { _tabController = x; }
	static TabController get tabController => NavigationBus._tabController;
	static TabController _tabController;

	static StreamSubscription registerNavigationListener(Function listener) {
		
		return _bus.on<AppNavEvent>().listen(listener);
	}

	static StreamSubscription registerAnimationListener(Function listener) {
		
		return _bus.on<TabAnimationEvent>().listen(listener);
	}

	static void registerTabController(TabController controller) {

		_tabController = controller;
		_tabController.animation.addListener(NavigationBus.onUpdateTabAnimation);
	}

	static void onUpdateTabAnimation() {

		_bus.fire(TabAnimationEvent());
	}
	
	static void testFire() {

		_bus.fire(AppNavEvent('/'));
	}

	static Future<void> returnTo(String route) {

		switch (route) {

			case '/':
			case '/':
			return null;
		}

		return null;
	}

	static Future<void> navigateTo(String route) {

		switch (route) {

			case '/':
			case '/':
			return null;
		}

		return null;
	}
}