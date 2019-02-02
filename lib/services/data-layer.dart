// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../types/data-model.dart';
import '../types/data-query.dart';

abstract class DataLayer {

	static Database _db;

	static int get _version { return 1; }

	static Future<void> init() async {

		String _path = await getDatabasesPath() + 'prezence';
		_db = await openDatabase(_path, version: DataLayer._version, onCreate: DataLayer.onCreate);
	}

	static void onCreate(Database db, int version) async {

		await db.execute('CREATE TABLE history (id INTEGER PRIMARY KEY, event_timestamp TEXT, minutes INTEGER)');
		await db.execute('CREATE TABLE settings (name TEXT PRIMARY KEY, value TEXT)');
	}

	static Future<List<Map<String, dynamic>>>  rawQuery(String sql) {
		
		return _db.rawQuery(sql);
	}

	static Future<List<Map<String, dynamic>>> query(String table, DataQuery query) async {

		return await _db.query(
			table,
			columns: query.columns,
			distinct: query.distinct,
			groupBy: query.groupBy,
			having: query.having,
			limit: query.limit,
			offset: query.offset,
			orderBy: query.orderBy,
			where: query.where,
			whereArgs: query.whereArgs);
	}

	static Future<int> insert(String table DataModel model) async {

		return await _db.insert(table, model.toMap());
	}

	static Future<int> update(String table, DataModel model) async {

		return await _db.update(table, model.toMap(),  where: 'id = ?', whereArgs: [model.id]);
	}
}