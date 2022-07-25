// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';

// Future<AudioHandler> initAudioService() async {
//   return await AudioService.init(
//     builder: () => MyAudioHandler(),
//     config: const AudioServiceConfig(
//       androidNotificationChannelId: 'com.example.music_player',
//       //هست androidManifest  نام تجاری نرم افزار که ما در
//       androidNotificationChannelName: 'Music playback',
//       //نامی که در نوتیفیکشن نشان میدهد
//       androidStopForegroundOnPause: true,
//       //برای از بین بردن نوتیفیکشن برنامه
//       androidNotificationOngoing: true,
//       //برای از بین بردن نوتیفیکشن برنامه
//     ),
//   );
// }

// class MyAudioHandler extends BaseAudioHandler {
//   final _audioPlayer = AudioPlayer();
//   final _playList = ConcatenatingAudioSource(children: []);
//   MyAudioHandler() {
//     _loadEmptyList();
//     _notifiAudioHandlerPlaybackEvents();
//     _listenToChangeIndexSong();
//     _listenToChangeInDuration();
//     _listenSequenceStateChange();
//   }
//   _loadEmptyList() async {
//     await _audioPlayer.setAudioSource(_playList);
//   }

//   void _notifiAudioHandlerPlaybackEvents() {
//     _audioPlayer.playbackEventStream.listen(
//       (PlaybackEvent event) {
//         final playing = _audioPlayer.playing;
//         playbackState.add(
//           playbackState.value.copyWith(
//             controls: [
//               MediaControl.skipToPrevious,
//               if (playing) MediaControl.pause else MediaControl.play,
//               MediaControl.skipToNext,
//               MediaControl.stop,
//             ],
//             systemActions: const {
//               MediaAction.seek,
//             },
//             androidCompactActionIndices: const [0, 1, 3],
//             processingState: {
//               ProcessingState.idle: AudioProcessingState.idle,
//               ProcessingState.loading: AudioProcessingState.loading,
//               ProcessingState.buffering: AudioProcessingState.buffering,
//               ProcessingState.ready: AudioProcessingState.ready,
//               ProcessingState.completed: AudioProcessingState.completed,
//             }[_audioPlayer.processingState]!,
//             repeatMode: const {
//               LoopMode.off: AudioServiceRepeatMode.none,
//               LoopMode.one: AudioServiceRepeatMode.one,
//               LoopMode.all: AudioServiceRepeatMode.all,
//             }[_audioPlayer.loopMode]!,
//             playing: playing,
//             updatePosition: _audioPlayer.position,
//             bufferedPosition: _audioPlayer.bufferedPosition,
//             queueIndex: event.currentIndex,
//           ),
//         );
//       },
//     );
//   }

//   _listenToChangeInDuration() {
//     _audioPlayer.durationStream.listen((duration) {
//       final index = _audioPlayer.currentIndex; //index موزیک فعلی را میگیرد
//       final newQueue = queue.value; //لیست اهنگ ها را به ما میدهد
//       if (newQueue.isEmpty || index == null) return;
//       final oldmediaItem = newQueue[index]; //اهنگ فعلی
//       final newMetaItem =
//           oldmediaItem.copyWith(duration: duration); //اهنگ فعلی با زمان جدید
//       newQueue[index] = newMetaItem; //ان موزیک فعلی را تغییرش بده
//       queue.add(newQueue);
//       mediaItem.add(newMetaItem);
//     });
//   }

//   _listenToChangeIndexSong() {
//     _audioPlayer.currentIndexStream.listen((song) {
//       final playlist = queue.value;
//       if (playlist.isEmpty) return;
//       mediaItem.add(playlist[song ?? 0]);
//     });
//   }

//   _listenSequenceStateChange() {
//     _audioPlayer.sequenceStateStream.listen((sequenceState) {
//       final sequence = sequenceState!.effectiveSequence;

//       ///
//       if (sequence.isEmpty || sequence == null) return;
//       final items = sequence.map((item) => item.tag as MediaItem);
//       queue.add(items.toList());
//     });
//   }

//   @override
//   Future<void> addQueueItems(List<MediaItem> mediaItems) async {
//     final audioSource = mediaItems
//         .map((song) => AudioSource.uri(
//               Uri.parse(song.extras!['url'] ?? ''),
//               tag: song,
//             ))
//         .toList();
//     if (queue.value.length < mediaItems.length) {
//       _playList.addAll(audioSource);
//     }
//     if (queue.value.length < mediaItems.length) {
//       final newQueue = queue.value..addAll(mediaItems);
//       queue.add(newQueue);
//     }
//   }
// //   @override
// //   Future<void> addQueueItems(List<MediaItem> mediaItems) async {
// //     //یک بار پلی لیست را بهش میدهیم justAudio برای
// //     final audioSource = mediaItems
// //         .map((songs) => AudioSource.uri(
// //               Uri.parse(songs.extras!['url']),///
// //               tag: songs,
// //             ))
// //         .toList();
// //     _playList.addAll(audioSource);
// // //برای نمایش هم لیست را میفرستیم
// //
// //     if (queue.value.length < mediaItems.length) {
// //       final newQueue = queue.value..addAll(mediaItems);
// //       queue.add(newQueue);
// //     }
// //   }

//   @override
//   Future<void> play() async {
//     _audioPlayer.play();
//   }

//   @override
//   Future<void> pause() async {
//     _audioPlayer.pause();
//   }

//   @override
//   Future<void> skipToNext() async {
//     _audioPlayer.seekToNext();
//   }

//   @override
//   Future<void> skipToPrevious() async {
//     _audioPlayer.seekToPrevious();
//   }

//   @override
//   Future<void> seek(Duration position) async {
//     _audioPlayer.seek(position);
//   }

//   @override
//   Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
//     switch (repeatMode) {
//       case AudioServiceRepeatMode.none:
//         _audioPlayer.setLoopMode(LoopMode.off);
//         break;
//       case AudioServiceRepeatMode.one:
//         _audioPlayer.setLoopMode(LoopMode.one);
//         break;
//       case AudioServiceRepeatMode.all:
//         _audioPlayer.setLoopMode(LoopMode.all);
//         break;
//       case AudioServiceRepeatMode.group:
//     }
//   }

//   @override
//   Future<void> androidSetRemoteVolume(int volumeIndex) async {
//     if (volumeIndex == 0) {
//       _audioPlayer.setVolume(0);
//     } else {
//       _audioPlayer.setVolume(1);
//     }
//   }

//   @override
//   Future<void> skipToQueueItem(int index) async {
//     _audioPlayer.seek(Duration.zero, index: index);
//   }
// }
// //  void _notifyAudioHandlerPlaybackEvents() {
// //     _audioPlayer.playbackEventStream.listen((PlaybackEvent event) {
// //       final playing = _audioPlayer.playing; //return bool
// //       playbackState.add(playbackState.value.copyWith(
// //         //مقادیر دلخواه را بهش میدهیم
// //         controls: [
// //           //button for Notification
// //           MediaControl.skipToPrevious,
// //           if (playing) MediaControl.pause else MediaControl.play,
// //           MediaControl.stop,
// //           MediaControl.skipToNext,
// //         ],
// //         //اضافه بر کنترل میشود در نوتیف قرار داد
// //         systemActions: const {
// //           MediaAction.seek,
// //         },
// //         androidCompactActionIndices: const [
// //           0,
// //           1,
// //           3
// //         ], //در حالت جمع بودن به چه صورت باشد
// //         processingState: //Connect the AudioHandler to JustAudio To Use method of JustAudio
// //             const {
// //           ProcessingState.idle: AudioProcessingState.idle,
// //           ProcessingState.loading: AudioProcessingState.loading,
// //           ProcessingState.buffering: AudioProcessingState.buffering,
// //           ProcessingState.ready: AudioProcessingState.ready,
// //           ProcessingState.completed: AudioProcessingState.completed,
// //         }[_audioPlayer.processingState]!,
// //         repeatMode: const {
// //           LoopMode.off: AudioServiceRepeatMode.none,
// //           LoopMode.all: AudioServiceRepeatMode.all,
// //           LoopMode.one: AudioServiceRepeatMode.one,
// //         }[_audioPlayer.loopMode]!,
// //         playing: playing,
// //         updatePosition: _audioPlayer.position,
// //         bufferedPosition: _audioPlayer.bufferedPosition,
// //         queueIndex: event
// //             .currentIndex, //یعنی ان موزیکی که همین الان هست و داره پلی میشه
// //       ));
// //     });
// //   }




///AudioServicesCode


// GetIt getIt = GetIt.instance;

// Future setupinitService() async {
//   getIt.registerSingleton<AudioHandler>(await initaudioService());
//   getIt.registerLazySingleton<PlayListRepository>(() => MyPlayList());
//   getIt.registerLazySingleton<PageManager>(() => PageManager());
// }