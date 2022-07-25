import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initaudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.musicplayer_new',
      androidNotificationChannelName: 'Music player',
      androidStopForegroundOnPause: true,
      androidNotificationOngoing: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler {
  final _audioPlayer = AudioPlayer();

  final _playList = ConcatenatingAudioSource(children: []);
  MyAudioHandler() {
    _loadEmptyList();
    _notifiAudioHandlerPlaybackEvents();
    _listenToChangeIndexSong();
    _listenToChangeInDuration();
    _listenSequenceStateChange();
  }
  _loadEmptyList() async {
    await _audioPlayer.setAudioSource(_playList);
  }

  void _notifiAudioHandlerPlaybackEvents() {
    _audioPlayer.playbackEventStream.listen(
      (PlaybackEvent event) {
        final playing = _audioPlayer.playing;
        playbackState.add(
          playbackState.value.copyWith(
            controls: [
              MediaControl.skipToPrevious,
              if (playing) MediaControl.pause else MediaControl.play,
              MediaControl.skipToNext,
              MediaControl.stop,
            ],
            systemActions: const {
              MediaAction.seek,
            },
            androidCompactActionIndices: const [0, 1, 2],
            processingState: {
              ProcessingState.idle: AudioProcessingState.idle,
              ProcessingState.loading: AudioProcessingState.loading,
              ProcessingState.buffering: AudioProcessingState.buffering,
              ProcessingState.ready: AudioProcessingState.ready,
              ProcessingState.completed: AudioProcessingState.completed,
            }[_audioPlayer.processingState]!,
            repeatMode: const {
              LoopMode.off: AudioServiceRepeatMode.none,
              LoopMode.one: AudioServiceRepeatMode.one,
              LoopMode.all: AudioServiceRepeatMode.all,
            }[_audioPlayer.loopMode]!,
            playing: playing,
            updatePosition: _audioPlayer.position,
            bufferedPosition: _audioPlayer.bufferedPosition,
            queueIndex: event.currentIndex,
          ),
        );
      },
    );
  }

  _listenToChangeInDuration() {
    _audioPlayer.durationStream.listen((duration) {
      final index = _audioPlayer.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  _listenSequenceStateChange() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      final sequence = sequenceState!.effectiveSequence;
      // ignore: unnecessary_null_comparison
      if (sequence.isEmpty || sequence == null) return;
      final items = sequence.map((item) => item.tag! as MediaItem);
      queue.add(items.toList());
    });
  }

  //listen void for check playlist
  _listenToChangeIndexSong() {
    _audioPlayer.currentIndexStream.listen((index) {
      final playList = queue.value;
      if (playList.isEmpty) return;
      mediaItem.add(playList[index ?? 0]);
    });
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audioSource = mediaItems
        .map(
          (mediaItem) => AudioSource.uri(
            Uri.parse(
              mediaItem.extras!['url'],
            ),
            tag: mediaItems,
          ),
        )
        .toList();
    if (_playList.length < mediaItems.length) {
      _playList.addAll(audioSource);
    }
    if (queue.value.length < mediaItems.length) {
      final newQueue = queue.value..addAll(mediaItems);
      queue.add(newQueue);
    }
  }

  @override
  Future<void> play() async {
    _audioPlayer.play();
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed);
  }

  @override
  Future<void> pause() async {
    _audioPlayer.pause();
  }

  @override
  Future<void> skipToNext() async {
    _audioPlayer.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    _audioPlayer.seekToPrevious();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.all:
        _audioPlayer.setShuffleModeEnabled(false);
        _audioPlayer.setLoopMode(LoopMode.all);
        break;
      case AudioServiceRepeatMode.one:
        _audioPlayer.setShuffleModeEnabled(false);
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
    }
  }

  // void onShuffleButtonPressed() async {
  //   _audioPlayer.setShuffleModeEnabled(true);
  //   _audioPlayer.shuffle();
  //   _audioPlayer.sequenceStateStream
  //       .map((state) => state?.effectiveSequence)
  //       .distinct()
  //       .map((sequence) =>
  //           sequence?.map((source) => source.tag as MediaItem).toList())
  //       .pipe(queue);
  // }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    // final oldIndices = _audioPlayer.effectiveIndices!;
    switch (shuffleMode) {
      case AudioServiceShuffleMode.all:
        _audioPlayer.setShuffleModeEnabled(true);
        _audioPlayer.shuffle();
        // final playlist = oldIndices.map((index) => queue.value[index]).toList();
        // queue.add(playlist);
        _audioPlayer.sequenceStateStream
            .map((state) => state?.effectiveSequence)
            .distinct()
            .map((sequence) =>
                sequence?.map((source) => source.tag as MediaItem).toList())
            .pipe(queue);

        break;
      case AudioServiceShuffleMode.group:

      case AudioServiceShuffleMode.none:
        _audioPlayer.setShuffleModeEnabled(true);
        break;
    }
  }

  @override
  Future<void> androidSetRemoteVolume(int volumeIndex) async {
    if (volumeIndex == 0) {
      _audioPlayer.setVolume(0);
    } else {
      _audioPlayer.setVolume(1);
    }
  }

  @override
  Future<void> seek(Duration position) async {
    _audioPlayer.seek(position);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    _audioPlayer.seek(Duration.zero, index: index);
  }
}
