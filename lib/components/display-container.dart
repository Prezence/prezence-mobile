// Prezence
// @copyright Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:math';

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

	get animation { return _animation; }

	Animation _animation;

	@override
	void initState() {

		super.initState();
		_controller = new TabController(vsync: this, length: widget.screens.length);
		_animation = _controller.animation;
	}

	@override
	void dispose() {

		super.dispose();
		_controller.dispose();
	}

	@override
	Widget build(BuildContext context) {

		var _index = 0;
		var _tabs = widget.screens.map<Tab>((ScreenView screen, { int index }) {
			Tab _tab = Tab(
				// child: new CustomTab(index: _index, icon: screen.icon, selectedIndex: selected)
				// text: "ASDF",
				icon: new CustomTab(index: _index, icon: screen.icon, selectedIndex: selected, animation: _animation),
			);
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

					Column(	
						mainAxisAlignment: MainAxisAlignment.end,
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: [
							
							TabBar(
								labelPadding: EdgeInsets.zero,
								controller: _controller,
								indicatorWeight: 4,
								tabs: _tabs,
								indicatorPadding: EdgeInsets.all(1)
							)
						]
					)
				]	
			)
		);
    }
}


class CustomTab extends StatefulWidget {

	const CustomTab({
		Key key,
		@required Image icon,
		@required int index,
		@required int selectedIndex,
		@required Animation animation

	}) : _icon = icon, _index = index, _selectedIndex = selectedIndex, _animation = animation, super(key: key);

	final Image _icon;

	final int  _index;

	final int _selectedIndex;

	final Animation _animation;

  @override
  CustomTabState createState() {
    return new CustomTabState();
  }
}

class CustomTabState extends State<CustomTab> {

	get isSelected => (widget._selectedIndex == widget._index);

	@override
	Widget build(BuildContext context) {

		return AnimatedBuilder(
			animation: widget._animation,
			child: widget._icon,
			builder: (BuildContext context, Widget child) {
				
				int index = widget._index;
				double value = widget._animation.value;
				double delta = value - index + 1;

				double opacity = (delta >= 0.0 && delta <= 1.0) 
					? delta
					: (delta > 1 && delta < 2) ? (2 - delta) : 0;

				if (opacity > 0.84) { opacity = 0.84; }
				if (opacity < 0.26) { opacity = 0.26; }
				return Container(

					constraints: BoxConstraints.expand(),
					decoration: BoxDecoration(
						gradient: LinearGradient(
							begin: Alignment.topCenter,
							end: Alignment.bottomCenter,
							colors: [
								const Color.fromARGB(8, 16, 32, 16),
								const Color.fromARGB(192, 32, 16, 32)
							]
						)
					),
					child: Padding(
						
						padding: EdgeInsets.only(bottom: 4, top: 8),
						child: Opacity(
							opacity: opacity,
							child: widget._icon
						)
					)
				);
			}
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