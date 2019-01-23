// Prezence
// @copyright Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import '../components/background-video.dart';
import '../types/screen-view.dart';

class DisplayContainer extends StatefulWidget {

    DisplayContainer({ Key key, @required this.title, @required this.screens }) : super(key: key);

    final String title;

	final List<ScreenView> screens;

    @override
    _DisplayContainerState createState() => _DisplayContainerState();
}

class _DisplayContainerState extends State<DisplayContainer> with SingleTickerProviderStateMixin {

	TabController _controller;

	get selected { return _selected; }

	int _selected;

	@override
	void initState() {

		super.initState();
		_controller = new TabController(vsync: this, length: widget.screens.length);
	}

	@override
	void dispose() {

		super.dispose();
		_controller.dispose();
	}

	@override
	Widget build(BuildContext context) {

		Size size = MediaQuery.of(context).size;

		_controller.addListener(() {
			print("changed index to: " + _controller.index.toString());
			setState(() { _selected = _controller.index; }); 
		});

		var _index = 0;
		var _tabs = widget.screens.map<Tab>((ScreenView screen, { int index }) {
			Tab _tab = Tab(child: new CustomTab(index: _index, icon: screen.icon, selectedIndex: selected));
			_index++;
			return _tab;
		}).toList();

		return Scaffold(
			
			appBar:null,

			body: Stack(

				alignment: AlignmentDirectional.topStart,
				children: <Widget>[
					
					BackgroundVideo(assetName: 'assets/videos/zenstones.mp4'),
					
					TabBarView(
						controller: _controller,
						children: widget.screens.map<Widget>((ScreenView screen) { return screen.widget; }).toList(),
					),
					NotificationListener(

						onNotification: (Notification notification) { print("notification: " + notification.toString()); },

						child: Padding(

							padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
							child: Column(
								mainAxisAlignment: MainAxisAlignment.end,
								children: [
									TabBar(
										labelPadding: EdgeInsets.zero,
										controller: _controller,
										indicatorWeight: 4,
										tabs: _tabs,
										indicatorPadding: EdgeInsets.all(1),
										
										
									)
								]
							)
						)
					)
				]	
			)
		);
    }
}

class CustomTabBar extends TabBar {

	CustomTabBar({
		Key key,
		@required List<Tab> tabs
	}) : super(key: key, tabs: tabs);

	@override
	getPreferredSize() {

	}
}

class CustomTab extends StatefulWidget {

	const CustomTab({
		Key key,
		@required Image icon,
		@required int index,
		@required int selectedIndex

	}) : _icon = icon, _index = index, _selectedIndex = selectedIndex, super(key: key);

	final Image _icon;

	final int  _index;

	final int _selectedIndex;

  @override
  CustomTabState createState() {
    return new CustomTabState();
  }
}

class CustomTabState extends State<CustomTab> {

	get isSelected => (widget._selectedIndex == widget._index);

	@override
	Widget build(BuildContext context) {

		return Container(
			height: 320,
		  	constraints: BoxConstraints.expand(),
			decoration: BoxDecoration(
				color: Color.fromARGB(128, 32, 16, 32),

				// border: Border.all(color: Colors.teal[600]),
				
				// boxShadow: [
				// 	BoxShadow(
				// 		color: Color.fromARGB(128, 16, 32, 16),
				// 		blurRadius: 2,
				// 		offset: Offset(3.0, 3.0)
				// 	)
				// ]
			),
			child: Padding(
				
				padding: EdgeInsets.only(bottom: 6, top: 6),
				child: Opacity(
					opacity: isSelected ? 0.8 : 0.4,
					child: widget._icon
				)
			)
		
		);

		// (_selectedIndex == _index) 
		// 	? 
		// 	: 
	}
}



// class BottomScrollNav extends StatefulWidget {

// 		const BottomScrollNav({
// 			Key key,
// 			@required Size itemSize
// 		}) : _itemSize = itemSize, super(key: key);

// 	@override
// 	BottomScrollNavState createState() => new BottomScrollNavState();

// 	final Size _itemSize;
// }

// class BottomScrollNavState extends State<BottomScrollNav> {

// 	double _scroll = 0.0;

// 	get scroll { return this._scroll; }

// 	bool _onNotification(ScrollNotification notification) {

// 		setState(() { _scroll = notification.metrics.pixels; });
// 		return true;
// 	}

// 	@override
// 	Widget build(BuildContext context) {

// 		return NotificationListener(

// 			onNotification: _onNotification,

// 			child: CustomScrollView(
// 				scrollDirection: Axis.horizontal,
				
// 				slivers: <Widget>[ 
// 					SliverList(
					
// 					// scrollDirection: Axis.horizontal,
					
// 					delegate: SliverChildListDelegate([

// 						NavListItem(
// 							assetName: 'assets/images/icon-meditation-bowl.png',
// 							delta: this.scroll,
// 							globalKey: new GlobalKey(),
// 							size: widget._itemSize,
// 							index: 1

// 						),
// 						NavListItem(
// 							assetName: 'assets/images/icon-headphones.png',
// 							delta: this.scroll,
// 							globalKey: new GlobalKey(),
// 							size: widget._itemSize,
// 							index: 2,
// 						),
// 						NavListItem(
// 							assetName: 'assets/images/icon-meditation-bowl.png',
// 							delta: this.scroll,
// 							globalKey: new GlobalKey(),
// 							size: widget._itemSize,
// 							index: 3,
// 						),
// 						NavListItem(
// 							assetName: 'assets/images/icon-headphones.png',
// 							delta: this.scroll,
// 							globalKey: new GlobalKey(),
// 							size: widget._itemSize,
// 							index:4
// 						),
// 					])
// 				)]
// 			),
// 		);
// 	}
// }

// class NavListItem extends StatefulWidget {

// 	const NavListItem({
// 		Key key,
// 		@required GlobalKey globalKey,
// 		@required String assetName,
// 		@required double delta,
// 		@required Size size,
// 		@required int index
// 	}) : _index = index, _size = size, _globalKey = globalKey, _assetName = assetName, _delta = delta, super(key: key);

// 	@override
// 	NavListItemState createState() => new NavListItemState();

// 	final String _assetName;

// 	final double _delta;

// 	final GlobalKey _globalKey;

// 	final Size _size;

// 	final int _index;

// }

// class NavListItemState extends State<NavListItem> {

// 	@override
// 	Widget build(BuildContext context) {

// 		Offset _offset = Offset(widget._delta / 1000, widget._delta / 1000); // changed

// 		double delta = 1.01 * widget._delta;

// 		print(delta);

// 		// Am I in view?

// 		int index = widget._index;
// 		double width = widget._size.width;

// 		double center = width / 2;
// 		double mycenter = ((index) * width) - center; 

// 		var test =  (widget._delta - mycenter).abs();
// 		print("test: " + test.toString());
// 		var distance = 140 / test;
// 		print("distance" + distance.toString());


// 		// var object = widget._globalKey?.currentContext?.findRenderObject();
// 		// var translation = object?.getTransformTo(null)?.getTranslation();
// 		// var size = object?.semanticBounds?.size;

// 		return InkWell(
// 			splashColor: Colors.tealAccent,
// 		  child: Transform(  

// 		  	transform: Matrix4.identity()
// 		  		..setEntry(3, 2, 0.001) // perspective
// 		  		..scale(distance),
// 		  		//..rotateX(1.01 * _offset.dy), // changed
		  		
// 		  		// ..rotateY(-1.01 * _offset.dx), // changed

// 		  	alignment: FractionalOffset.center,
// 		  	child: Padding(
// 		  		padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),

// 		  		child: Container(
		  			
// 		  			decoration: BoxDecoration(
// 		  				color: Color.fromARGB(128, 32, 16, 32),

// 		  				// border: Border.all(color: Colors.teal[600]),
		  				
// 		  				boxShadow: [
// 		  					BoxShadow(
// 		  						color: Color.fromARGB(128, 16, 32, 16),
// 		  						blurRadius: 2,
// 		  						offset: Offset(3.0, 3.0)
// 		  					)
// 		  				]
// 		  			),
// 		  			width: widget._size.width,
		  			
// 		  			child: Opacity(
// 						opacity: 0.6,
// 						child: Image.asset(widget._assetName)
// 					)
// 		  		),
// 		  	)
// 		  ),
// 		);
	
// 	}
// }