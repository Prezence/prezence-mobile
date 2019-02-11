// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import './media-bus.dart';
import './device-info.dart';
import './db.dart';

abstract class ServiceBus {

	static Future<void> init() async {

		await DeviceInfo.init();
		await DB.init();
		return MediaBus.init();
	}
}