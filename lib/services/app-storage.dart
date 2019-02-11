// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
// import 'package:path_provider/path_provider.dart';
import '../types/meditation-stats.dart';
import '../types/utc-timestamp.dart';
import '../types/data-query.dart';
import '../models/history-item.dart';
import '../services/db.dart';

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

		return DB.insert('history', item);
	}

	static Future<List<HistoryItem>> getHistory() async {
		
		List<String> _columns = ['id', 'minutes', 'event_timestamp'];
		List<Map<String, dynamic>> _result = await DB.query('history', DataQuery(columns: _columns));

		Iterable<HistoryItem> _items = _result.map((Map<String, dynamic> item) => new HistoryItem.fromMap(item));
		return _items.toList();
	}

	static Future<MeditationTotals> getTotals() async {

		String _query = 'select sum(minutes) as total_minutes, count(id) as total_sessions from history';
		List<Map<String, dynamic>> _result = await DB.rawQuery(_query);
		
		bool hasResults = _result.length > 0;
		
		return MeditationTotals.fromMap({ 
			'total_minutes': (hasResults) ? _result[0]['total_minutes'] : 0, 
			'total_sessions': (hasResults) ? _result[0]['total_sessions'] : 0
		});
	}
	
	static Future<UTCTimestamp> getLastSession() async {

		String _query = 'select event_timestamp from history order by id desc limit 1';
		List<Map<String, dynamic>> _result = await DB.rawQuery(_query);
		
		if (_result.length == 0) { return null; }

		String timestamp = _result[0]['event_timestamp'];
		UTCTimestamp dateTime = UTCTimestamp.parse(timestamp);
		return dateTime;
	}

	static Future<void> test() async {

		HistoryItem item = new HistoryItem(Duration(minutes: 5));
		AppStorage.logHistoryItem(item);

		String _query = "select * from history";
		List<Map<String, dynamic>> _result = await DB.rawQuery(_query);
		
	
		for (Map<String, dynamic> item in _result) {
			print(item);
		}
	}

	static Future<void> clearHistory() async {

		return await DB.rawQuery('delete from history');
	}
}