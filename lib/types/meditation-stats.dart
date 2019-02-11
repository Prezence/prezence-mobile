// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import './utc-timestamp.dart';

class MeditationTotals {

	MeditationTotals();

	int totalMinutes;
	int totalSessions;

	Duration get duration {

		return Duration(minutes: totalMinutes);
	}

	String get totalTimeString {

		Duration _duration = this.duration;
		int _hours = _duration.inHours;
		int _minutes = _hours > 0 
			? (_duration.inMinutes - (_hours * 60)).floor()
			: _duration.inMinutes;

		String str = "";

		if (_hours > 0) { str += _hours.toString() + " hours ";	}
		return str + _minutes.toString() + (_minutes == 1 ? " minute" : " minutes");
	}

	MeditationTotals.fromMap(Map<String, int> map) {

		totalMinutes = map['total_minutes'];
		totalSessions = map['total_sessions'];
	}

	MeditationTotals.empty() {

		totalMinutes = 0;
		totalSessions = 0;
	}
}

class MeditationStats {

	MeditationStats({ this.totals, this.lastSession });

	MeditationTotals totals;
	UTCTimestamp lastSession;

	MeditationStats.empty() {

		totals = MeditationTotals.empty();
		lastSession = null;
	}
}