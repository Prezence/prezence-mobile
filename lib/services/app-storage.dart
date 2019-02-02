// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
// import 'package:path_provider/path_provider.dart';
import '../types/meditation-stats.dart';
import '../types/utc-timestamp.dart';
import '../models/history-item.dart';
import '../services/data-layer.dart';

class AppStorage {

	// Future<String> get _localPath async {

	// 	final directory = await getApplicationDocumentsDirectory();
	// 	return directory.path;
	// }

	// Future<File> get _localFile async {

	// 	final path = await _localPath;
	// 	return File('$path/stats.txt');
	// }

	static Future<int> logHistoryItem(HistoryItem item) async {

		return DataLayer.insert('history', item);
	}

	static Future<MeditationTotals> getTotals() async {

		String _query = 'select sum(minutes) as total_minutes, count(id) as total_sessions from history';
		List<Map<String, dynamic>> _result = await DataLayer.rawQuery(_query);
		
		int totalMinutes = _result[0]['total_minutes'];
		int totalSessions = _result[0]['total_sessions'];

		return MeditationTotals.fromMap({ 'minutes': totalMinutes, 'sessions': totalSessions });
	}
	
	static Future<UTCTimestamp> getLastSession() async {

		String _query = 'select event_timestamp from history order by id desc limit 1';
		List<Map<String, dynamic>> _result = await DataLayer.rawQuery(_query);
		
		String timestamp = _result[0]['event_timestamp'];
		UTCTimestamp dateTime = UTCTimestamp.parse(timestamp);
		return dateTime;
	}
}