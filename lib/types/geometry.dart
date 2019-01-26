// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';

class Geometry {

	// const MetricsService({  });
	Geometry(BuildContext context) {

		size = MediaQuery.of(context).size;
		root = size.width / 1.616;
		rootQuarter = root / 4;
		rootEighth = root / 8;
		rootThird = root / 3;
		rootHalf = root / 2;
	}

	Size size;
	double root;
	double rootQuarter;
	double rootEighth;
	double rootThird;
	double rootHalf;
}