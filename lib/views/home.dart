// Prezence
// Copyright 2019 The Innovation Group

import 'dart:math';

import 'package:flutter/material.dart';
import '../components/background-video.dart';
import '../components/title-header.dart';

class HomeScreen extends StatefulWidget {

    HomeScreen({ Key key, this.title }) : super(key: key);

    final String title;

    @override
    _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

	@override
	void initState() {

		super.initState();
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			
			appBar: null,
			body:  Stack(

				alignment: AlignmentDirectional.topStart,
				children: <Widget>[
					
					new BackgroundVideo(assetName: 'assets/videos/zenstones.mp4'),

					new HomeScreenUX()
				]
			)
		);
			
		
            // floatingActionButton: FloatingActionButton(
            //     onPressed: _incrementCounter,
            //     tooltip: 'Increment',
            //     child: Icon(Icons.add),
            // ), // This trailing comma makes auto-formatting nicer for build methods.
    
    }
}

class HomeScreenUX extends StatelessWidget {

	const HomeScreenUX({
		Key key,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		Size _deviceSize = MediaQuery.of(context).size;

		double _padding = 0.0;
		double _width = _deviceSize.width * .90;

		Size _navItemSize = Size(_width + _padding, (_width + _padding) / 1.618);


		return Column(

			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[

				TitleHeader(),
				
				ConstrainedBox(
					constraints: BoxConstraints.expand(height: _navItemSize.height),
					child: new BottomScrollNav(itemSize: _navItemSize)
				)				
			],
		);
	}
}

class BottomScrollNav extends StatefulWidget {

		const BottomScrollNav({
			Key key,
			@required Size itemSize
		}) : _itemSize = itemSize, super(key: key);

	@override
	BottomScrollNavState createState() => new BottomScrollNavState();

	final Size _itemSize;
}

class BottomScrollNavState extends State<BottomScrollNav> {

	double _scroll = 0.0;

	get scroll { return this._scroll; }

	bool _onNotification(ScrollNotification notification) {

		setState(() { _scroll = notification.metrics.pixels; });
		return true;
	}

	@override
	Widget build(BuildContext context) {

		return NotificationListener(

			onNotification: _onNotification,

			child: CustomScrollView(
				scrollDirection: Axis.horizontal,
				
				slivers: <Widget>[ 
					SliverList(
					
					// scrollDirection: Axis.horizontal,
					
					delegate: SliverChildListDelegate([

						NavListItem(
							assetName: 'assets/images/icon-meditation-bowl.png',
							delta: this.scroll,
							globalKey: new GlobalKey(),
							size: widget._itemSize,
							index: 1

						),
						NavListItem(
							assetName: 'assets/images/icon-headphones.png',
							delta: this.scroll,
							globalKey: new GlobalKey(),
							size: widget._itemSize,
							index: 2,
						),
						NavListItem(
							assetName: 'assets/images/icon-meditation-bowl.png',
							delta: this.scroll,
							globalKey: new GlobalKey(),
							size: widget._itemSize,
							index: 3,
						),
						NavListItem(
							assetName: 'assets/images/icon-headphones.png',
							delta: this.scroll,
							globalKey: new GlobalKey(),
							size: widget._itemSize,
							index:4
						),
					])
				)]
			),
		);
	}
}

class NavListItem extends StatefulWidget {

	const NavListItem({
		Key key,
		@required GlobalKey globalKey,
		@required String assetName,
		@required double delta,
		@required Size size,
		@required int index
	}) : _index = index, _size = size, _globalKey = globalKey, _assetName = assetName, _delta = delta, super(key: key);

	@override
	NavListItemState createState() => new NavListItemState();

	final String _assetName;

	final double _delta;

	final GlobalKey _globalKey;

	final Size _size;

	final int _index;

}

class NavListItemState extends State<NavListItem> {

	@override
	Widget build(BuildContext context) {

		Offset _offset = Offset(widget._delta / 1000, widget._delta / 1000); // changed

		double delta = 1.01 * widget._delta;

		print(delta);

		// Am I in view?

		int index = widget._index;
		double width = widget._size.width;

		double center = width / 2;
		double mycenter = ((index) * width) - center; 

		var test =  (widget._delta - mycenter).abs();
		print("test: " + test.toString());
		var distance = 140 / test;
		print("distance" + distance.toString());


		// var object = widget._globalKey?.currentContext?.findRenderObject();
		// var translation = object?.getTransformTo(null)?.getTranslation();
		// var size = object?.semanticBounds?.size;

		return InkWell(
			splashColor: Colors.tealAccent,
		  child: Transform(  

		  	transform: Matrix4.identity()
		  		..setEntry(3, 2, 0.001) // perspective
		  		..scale(distance),
		  		//..rotateX(1.01 * _offset.dy), // changed
		  		
		  		// ..rotateY(-1.01 * _offset.dx), // changed

		  	alignment: FractionalOffset.center,
		  	child: Padding(
		  		padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),

		  		child: Container(
		  			
		  			decoration: BoxDecoration(
		  				color: Color.fromARGB(128, 32, 16, 32),

		  				// border: Border.all(color: Colors.teal[600]),
		  				
		  				boxShadow: [
		  					BoxShadow(
		  						color: Color.fromARGB(128, 16, 32, 16),
		  						blurRadius: 2,
		  						offset: Offset(3.0, 3.0)
		  					)
		  				]
		  			),
		  			width: widget._size.width,
		  			
		  			child: Opacity(
						opacity: 0.6,
						child: Image.asset(widget._assetName)
					)
		  		),
		  	)
		  ),
		);
	
	}
}