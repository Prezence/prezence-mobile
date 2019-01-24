// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';

class ScreenView {

	const ScreenView({ this.name, this.widget, this.icon });
	final String name;
	final Image icon;
	final Widget widget;
}