// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'package:event_bus/event_bus.dart';

class AppNavEvent { AppNavEvent(this.route); String route; }

abstract class NavBus { 

	static EventBus _bus = new EventBus();

	static StreamSubscription registerListener(Function listener) {
		
		return _bus.on<AppNavEvent>().listen(listener);
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