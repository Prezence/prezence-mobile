// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

class MeditationStats {

	const MeditationStats({ this.totalMinutes, this.totalSessions, this.lastMeditated });
	final int totalMinutes;
	final int totalSessions;
	final DateTime lastMeditated;

	@override
	String toString() {

		String str = this.totalMinutes.toString();
		return str;
	}

	static MeditationStats loadFromString(String data) {

		return MeditationStats(
			totalMinutes: int.parse(data),
			totalSessions: 0,
			lastMeditated: DateTime.now()
		);
	}

	static MeditationStats empty() {

		return MeditationStats(
			totalMinutes: 0,
			totalSessions: 0,
			lastMeditated: DateTime.now()
		);
	}
}