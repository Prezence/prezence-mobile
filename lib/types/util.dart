// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

class Util {

	static Iterable<int> range(int low, int high) sync* {

		for (int i = low; i < high; ++i) {
			yield i;
		}
	}

	static double scaleDouble(double value, double percent) {

		return 1.0 - ( 1.0 - (value * (1.0 - percent)) - percent );
	}
}