// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

class Util {

	static Iterable<int> range(int low, int high) sync* {

		for (int i = low; i < high; ++i) {
			yield i;
		}
	}
}