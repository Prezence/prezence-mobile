// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import '../types/meditation-stats.dart';
import '../types/utc-timestamp.dart';
import '../models/history-item.dart';
import './app-storage.dart';

abstract class AppMetrics {

	// const MetricsService({  });

	static Future<dynamic> getStats() async {
		
		try {
			MeditationTotals totals = await AppStorage.getTotals();
			UTCTimestamp lastSession = await AppStorage.getLastSession();
			MeditationStats stats = MeditationStats(lastSession: lastSession, totals: totals);
			return stats;

		}
		catch(ex) {
			print(ex);
		}

		return MeditationStats.empty();
	}

	static Future<void> logSession(Duration duration) {

		HistoryItem item = new HistoryItem(duration);
		return AppStorage.logHistoryItem(item);
	}
}