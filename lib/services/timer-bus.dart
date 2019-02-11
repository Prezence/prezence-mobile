// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:screen/screen.dart';

class TimerCompletedEvent {}
class TimerCancelledEvent extends TimerCompletedEvent {}
class TimerElapsedEvent { TimerElapsedEvent(this.remaining); Duration remaining; }

abstract class TimerBus { 

	static EventBus _bus = new EventBus();
	static Timer _timer;

	static Duration get duration => _duration;
	static Duration _duration = Duration.zero;

	static Duration get initialDuration => _initialDuration;
	static Duration _initialDuration = Duration.zero;

	static bool get isRunning { return _isRunning; }
	static bool _isRunning = false;

	static StreamSubscription registerElapsedListener(Function listener) {
		
		return _bus.on<TimerElapsedEvent>().listen(listener);
	}

	static registerCompletedListener(Function listener) {
		
		return _bus.on<TimerCompletedEvent>().listen(listener);
	}

	static void onTick(Timer t) {

		if (!isRunning) { return clear(); }

		_duration = _duration - Duration(seconds: 1);
		if (_duration.inSeconds == 0) {

			_bus.fire(TimerCompletedEvent());
			return clear();
		}
		
		_bus.fire(TimerElapsedEvent(_duration));
	}

	static void init(Duration duration) {
		
		if (TimerBus._timer != null) { 
			TimerBus._timer.cancel();}
		TimerBus._duration = TimerBus._initialDuration = duration;
	}

	static void start() {

		TimerBus._timer = Timer.periodic(Duration(seconds: 1), TimerBus.onTick);
		TimerBus._isRunning = true;
	}

	static void stop() {

		TimerBus._timer.cancel();
		TimerBus._isRunning = false;
	}

	static void clear() {
		
		try {
			TimerBus._duration = Duration.zero;
			TimerBus.stop();
		}
		catch(e) { TimerBus._bus = new EventBus(); }
		finally { TimerBus._timer = null; }
	}
}