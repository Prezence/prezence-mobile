// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class AnimationEvent { }

class AnimationUpdateEvent extends AnimationEvent {
 
	AnimationUpdateEvent(this.value); double value;
}

class AnimationTabScrollEvent extends AnimationUpdateEvent {
	AnimationTabScrollEvent(double _value) : super(_value);
}

class AnimationCompleteEvent extends AnimationEvent {

	AnimationCompleteEvent(this.remaining); Duration remaining;

}

abstract class AnimationBus { 

	static EventBus _bus = new EventBus();

	static set (TabController x) { _tabController = x; }
	static TabController get tabController => AnimationBus._tabController;
	static TabController _tabController;

	static Animation get tabAnimation {

		return _tabController != null
		? _tabController.animation
		: AlwaysStoppedAnimation(1.0);
	}

	static void onUpdateTabAnimation() {

		_bus.fire(AnimationTabScrollEvent(tabAnimation.value));
	}

	static StreamSubscription registerTabScrollListener(Function listener) {
		
		return _bus.on<AnimationTabScrollEvent>().listen(listener);
	}

	static void registerTabController(TabController controller) {

		_tabController = controller;
		_tabController.animation.addListener(onUpdateTabAnimation);
	}

}