// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../types/meditation-stats.dart';

class Storage {

	Future<String> get _localPath async {

		final directory = await getApplicationDocumentsDirectory();
		return directory.path;
	}

	Future<File> get _localFile async {

		final path = await _localPath;
		return File('$path/stats.txt');
	}

	Future<File> writeStats(MeditationStats stats) async {

		final file = await _localFile;
		return file.writeAsString(stats.toString());
	}

	Future<MeditationStats> readStats() async {

		try {
			final file = await _localFile;
			String contents = await file.readAsString();
			return MeditationStats.loadFromString(contents);
		} catch (e) {
			// If we encounter an error, return empty
			return MeditationStats.empty();
		}
	}
}