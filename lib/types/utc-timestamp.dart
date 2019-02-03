// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

class UTCTimestamp {

	UTCTimestamp(String timeString) : dateTime = DateTime.parse(timeString);

	UTCTimestamp.parse(String str) { dateTime =  DateTime.parse(str); }

	DateTime dateTime;

	@override
	String toString() { return dateTime.toUtc().toString(); }
}