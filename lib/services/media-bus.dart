// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:event_bus/event_bus.dart';

class MediaPlaybackEvent {}
class MediaStartedEvent extends MediaPlaybackEvent {}
class MediaElapsedEvent extends MediaPlaybackEvent {}
class MediaStoppedEvent extends MediaPlaybackEvent {}
class MediaCompleteEvent extends MediaPlaybackEvent {}
class MediaErrorEvent extends MediaPlaybackEvent {}
class MediaResetEvent extends MediaPlaybackEvent {}

// class TimerElapsedEvent { TimerElapsedEvent(this.remaining); Duration remaining; }

enum MediaPlayerState {
	READY,
	STOPPED,
	PLAYING,
	PAUSED,
	COMPLETE,
	ERROR
}

abstract class MediaBus { 

	static EventBus _bus = new EventBus(sync:  true);

	static AudioPlayer _audioPlayer = new AudioPlayer();

	static AudioCache _audioCache = new AudioCache(prefix: 'audio/', fixedPlayer: MediaBus._audioPlayer);

	static MediaPlayerState _playerState = MediaPlayerState.READY;

	static void _positionHandler(Duration duration) {

		// print(duration);
	}

	static void _completedHandler() {

		switch (MediaBus._playerState) {

			// Content playback is now complete
			case MediaPlayerState.PLAYING:
			case MediaPlayerState.PAUSED:

				_bus.fire(MediaCompleteEvent());
				MediaBus._playerState = MediaPlayerState.COMPLETE;
				return;

			// Content was already stopped when event fired
			case MediaPlayerState.COMPLETE:
			case MediaPlayerState.STOPPED:
			case MediaPlayerState.READY:

				MediaBus.reset(); // just in case
				return;

			case MediaPlayerState.ERROR:
				return;
		}
		// MediaBus._playerState = MediaPlayerState.READY;
	}

	static void init() {

		_audioPlayer.positionHandler = MediaBus._positionHandler; 
		_audioPlayer.completionHandler = MediaBus._completedHandler;
	}

	static void reset() {
		
		_audioPlayer.stop();
		_bus.fire(MediaResetEvent());
		MediaBus._playerState = MediaPlayerState.READY;
	}

	static Future<dynamic> playSoundEffect(String assetName) async {

		return await _audioCache.play(assetName);
	}

	static Future<dynamic> playAudioTrack(String assetName) async {

		if (MediaBus._playerState == MediaPlayerState.PLAYING) { return false; }
		MediaBus._playerState = MediaPlayerState.PLAYING;
		return await _audioCache.play(assetName);
	}
}