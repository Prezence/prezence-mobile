// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import '../types/data-model.dart';
import '../types/utc-timestamp.dart';

class HistoryItem extends DataModel {

	HistoryItem(Duration duration) { 
		
		minutes = duration.inMinutes;
		eventTimestamp = UTCTimestamp.now();
	}

	int id;
	int minutes;
	UTCTimestamp eventTimestamp;

	@override
	toMap() {

		return <String, dynamic> {
			'id': id,
			'minutes': minutes,
			'event_timestamp': eventTimestamp.toString()
		};
	}

	@override
	HistoryItem.fromMap(Map<String, dynamic> map) {

		id = map['id'];
		minutes = map['minutes'];
		eventTimestamp = new UTCTimestamp(map['event_timestamp']);
	} 
}