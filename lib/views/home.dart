// Prezence
// Copyright 2019 The Innovation Group

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../components/title-header.dart';

class HomeScreen extends StatefulWidget {

    HomeScreen({ Key key, this.title }) : super(key: key);

    final String title;

    @override
    _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

	VideoPlayerController _controller;
	bool _isPlaying = false;

	@override
	void initState() {

		super.initState();

		_controller = VideoPlayerController.asset('assets/zenstones.mp4')
			..addListener(this.onVideoEvent)
			..initialize().then((_) {
			
				setState(() { });
				_controller.setLooping(true);
				_controller.play();
			});		


	}

	void onVideoEvent() {



		final bool isPlaying = _controller.value.isPlaying;

		if (isPlaying == _isPlaying) { return; }

		// _isPlaying = isPlaying;
		setState(() { _isPlaying = isPlaying; });
	}

	@override
	Widget build(BuildContext context) {

		_controller.play();

		return Scaffold(
			
			appBar: null,
			body:  Stack(
				alignment: AlignmentDirectional.topStart,
				children: <Widget>[
					
					Container(
						color: Colors.black
					),

					OverflowBox(
						maxWidth: double.infinity,
						alignment: Alignment.center,
						child: AspectRatio(
							aspectRatio: _controller.value.aspectRatio,
							child: VideoPlayer(_controller),
						),
						
					),

					// Container(
					// 	width: MediaQuery.of(context).size.width,

					// ),

					// new Positioned.fill(
						
					// 	child: ,
					// ),

					// AspectRatio(
					// 	aspectRatio: _controller.value.aspectRatio,
					// 	child: VideoPlayer(_controller)
					// ),

					// VideoPlayer(_controller),

					// UnconstrainedBox(
					// 	alignment: Alignment.center, 
					// 	child: VideoPlayer(_controller)
					// ),
								
					Column(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: <Widget>[
							new TitleHeader(),
						],
					)
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
