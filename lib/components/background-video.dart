
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {

	const BackgroundVideo({ Key key, @required String assetName })
		: _assetName = assetName, super(key: key);

	@override
	BackgroundVideoState createState() => new BackgroundVideoState();

	final String _assetName;
}

class BackgroundVideoState extends State<BackgroundVideo> {

	VideoPlayerController _controller;

	bool _isPlaying = false;
		
	void onVideoEvent() {

		final bool isPlaying = _controller.value.isPlaying;

		if (isPlaying == _isPlaying) { return; }
		setState(() { _isPlaying = isPlaying; });
	}

	@override
	void initState() {

		super.initState();

		_controller = VideoPlayerController.asset(widget._assetName)
			..addListener(this.onVideoEvent)
			..initialize().then((_) {
			
				setState(() { });
				_controller.setLooping(true);
				_controller.play();
			});	
	}

	@override
	Widget build(BuildContext context) {

		final OverflowBox _overflowBox = OverflowBox(

			maxWidth: double.infinity,
			alignment: Alignment.center,
			child: AspectRatio(
				aspectRatio: _controller.value.aspectRatio,
				child: VideoPlayer(_controller),
			)
		);

		return  Stack(

			alignment: AlignmentDirectional.topStart,
			children: <Widget>[
				Container( color: Colors.black ),
				_overflowBox
			]
		);
	}
}
