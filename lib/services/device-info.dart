// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'dart:async';
import 'package:device_info/device_info.dart';

abstract class DeviceInfo {

	static final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

	static AndroidDeviceInfo _androidInfo;
	static IosDeviceInfo _iosDeviceInfo;

	static bool get isPhysicalDevice {

		return (Platform.isAndroid && _androidInfo.isPhysicalDevice)
			|| (Platform.isIOS && _iosDeviceInfo.isPhysicalDevice);
	}
	
	static bool get canRenderVideo {
		
		return Platform.isAndroid || DeviceInfo.isPhysicalDevice;
	}

	static Future<void> init() async {

		if (Platform.isIOS) { 
			_iosDeviceInfo = await DeviceInfo._plugin.iosInfo;
		}
		else if (Platform.isAndroid) {
			_androidInfo = await DeviceInfo._plugin.androidInfo;
		}
		else { print('Unsupported platform detected'); }
	}
}