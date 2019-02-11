// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import './navigation-bus.dart';

enum PageDirection { LEFT, RIGHT, IDLE }

class AnimationEvent { }

class AnimationUpdateEvent extends AnimationEvent {
 
	AnimationUpdateEvent(this.value); double value;
}

class AnimationTabScrollEvent extends AnimationUpdateEvent {

	AnimationTabScrollEvent(double _value) : super(_value);
}

class AnimationCompleteEvent extends AnimationEvent {

	AnimationCompleteEvent(this.remaining);
	Duration remaining;
}

abstract class AnimationBus { 

	static EventBus _bus = new EventBus();

	static TabController get _tabController => NavigationBus.tabController;
	
	// static bool _tabIndexChanging = false;
	static PageDirection _direction = PageDirection.IDLE;

	static Animation get tabAnimation {

		return _tabController != null
		? _tabController.animation
		: AlwaysStoppedAnimation(1.0);
	}

	static void onUpdateTabAnimation() {
			
		if (_tabController.indexIsChanging) {

			_direction = (_tabController.index > _tabController.previousIndex)
				? PageDirection.RIGHT
				: PageDirection.LEFT;

			// print(_direction);
			// print(_tabController.offset);
			
			switch (_direction) {

				case PageDirection.RIGHT:

					if (_tabController.offset < -0.7) {
						// nimationBus.warpToTab(_tabController.index);
					}
					return;

				case PageDirection.LEFT:

					if (_tabController.offset > 0.7) {
						// AnimationBus.warpToTab(_tabController.index);
					}

					return;

				case PageDirection.IDLE:

					// _tabIndexChanging = false;
					return;
			}
		}

		// print ('offset: ' + _tabController.offset.toString());

		_bus.fire(AnimationTabScrollEvent(tabAnimation.value));
	}

	static void warpToTab(int index) {

		// _tabIndexChanging = false;
		_direction = PageDirection.IDLE;
		_tabController.animateTo(_tabController.index);
	}

	static StreamSubscription registerTabScrollListener(Function listener) {
		
		return _bus.on<AnimationTabScrollEvent>().listen(listener);
	}
}