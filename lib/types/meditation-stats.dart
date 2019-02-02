// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import './utc-timestamp.dart';

class MeditationTotals {

	MeditationTotals();

	int totalMinutes;
	int totalSessions;

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