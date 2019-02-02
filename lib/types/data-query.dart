// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

class DataQuery {

	DataQuery({ 
		this.distinct,
		this.columns,
		this.where,
		this.whereArgs,
		this.groupBy,
		this.having,
		this.orderBy,
		this.limit,
		this.offset
	});

	final bool distinct;
	final List<String> columns;
	final String where;
	final List<dynamic> whereArgs;
	final String groupBy;
	final String having;
	final String orderBy;
	final int limit;
	final int offset;
}