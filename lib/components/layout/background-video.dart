// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../services/device-info.dart';

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

	double get _aspectRatio {

		try { return _controller.value.aspectRatio; }
		catch(ex) { return 16/9; }
	}

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

		return  Stack(

			alignment: AlignmentDirectional.topStart,
			children: <Widget>[
				Container( color: Colors.black ),
				( 
					DeviceInfo.canRenderVideo 
		
					? OverflowBox(
						maxWidth: double.infinity,
						alignment: Alignment.center,
						child: AspectRatio(
							aspectRatio: _aspectRatio,
							child: VideoPlayer(_controller),
						)
					)

					: Container(
						decoration: BoxDecoration(
							image: DecorationImage(
								fit: BoxFit.cover,
								image: AssetImage('assets/images/video-placeholder.jpg')
							)
						)
					)
				)
			]
		);
	}
}