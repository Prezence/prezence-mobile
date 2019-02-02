// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

abstract class DataModel {

	int id;
	DataModel();
	Map<String, dynamic> toMap();
	DataModel.fromMap();
}