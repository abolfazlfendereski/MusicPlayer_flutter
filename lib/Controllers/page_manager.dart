// ignore: file_names

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_player/services/audio_service.dart';
import 'package:music_player/services/playlist_repository.dart';

class PageManager {
  final _audioHandler = getIt<AudioHandler>();
  // final AudioPlayer _audioPlayer;
  final progressBarNotifier = ValueNotifier<ProgressBarState>(ProgressBarState(
      buffered: Duration.zero, current: Duration.zero, total: Duration.zero));
  final bttonStateNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
  final detailMusicNotifier =
      ValueNotifier<MediaItem>(const MediaItem(id: '-1', title: ''));
  final playListNotifier = ValueNotifier<List<MediaItem>>([]);
  late final isfirstone = ValueNotifier<bool>(true);
  final isLastOne = ValueNotifier<bool>(true);
  final repeate = RepeatStateNotifier();
  final volumeStateNotifier = ValueNotifier<double>(1);
  final shuffleModeNotifier = ValueNotifier<bool>(false);

  PageManager() {
    _init();
    _listenChangeInPlayList();
  }

  void play() {
    //play music void

    _audioHandler.play();
  }

  void pause() {
//void pause Music
    _audioHandler.pause();
  }

  void _init() {
    _listenToCurrentSong();
    _loadPlayList();

    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();

    _listenToTotalDuration();
  }

  Future _loadPlayList() async {
    final songRepository = getIt<PlayListRepository>();
    final playlist = await songRepository.fethchPlayList();
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '-1',
              title: song['title'] ?? '',
              artist: song['artist'] ?? '',
              artUri: Uri.parse(song['artUri'] ?? '-1'),
              extras: {'url': song['url']},
            ))
        .toList();
    if (mediaItems.isEmpty) {
      return;
    } else {
      _audioHandler.addQueueItems(mediaItems);
    }
  }

  _listenToCurrentSong() {
    final playlist = _audioHandler.queue.value;

    _audioHandler.mediaItem.listen(
      (mediaItem) {
        detailMusicNotifier.value =
            mediaItem ?? const MediaItem(id: '-1', title: '');
        if (playlist.isEmpty || mediaItem == null) {
          isfirstone.value = true;
          isLastOne.value = false;
        } //
        else {
          isfirstone.value = playlist.first == mediaItem;
          isLastOne.value = playlist.last == mediaItem;
        }
      },
    );
  }

  _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playBackState) {
      final oldState = progressBarNotifier.value;
      progressBarNotifier.value = ProgressBarState(
          buffered: playBackState.bufferedPosition,
          current: oldState.current,
          total: oldState.total);
    });
  }

  _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressBarNotifier.value;
      progressBarNotifier.value = ProgressBarState(
          buffered: oldState.buffered,
          current: oldState.current,
          total: mediaItem!.duration ?? Duration.zero);
    });
  }

  _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressBarNotifier.value;
      progressBarNotifier.value = ProgressBarState(
          buffered: oldState.buffered,
          current: position,
          total: oldState.total);
    });
  }

  _listenChangeInPlayList() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        return;
      }
      final newList = playlist.map((item) => item).toList();
      playListNotifier.value = newList;
    });
  }

  void setSpeed(double val) async {
    await _audioHandler.setSpeed(val);
  }

  void onVolumePressed() {
    if (volumeStateNotifier.value != 0) {
      _audioHandler.androidSetRemoteVolume(0);

      volumeStateNotifier.value = 0;
    } else {
      _audioHandler.androidSetRemoteVolume(1);
      volumeStateNotifier.value = 1;
    }
  }

  // _listenChangeInPlayList() {
  //   _audioHandler.queue.listen((playlist) {
  //     if (playlist.isEmpty) return;
  //     final newList = playlist.map((items) => items).toList();
  //     playListNotifier.value = newList;
  //   });
  // }

  // _listenToCurrentSong() {
  //   final playlist = _audioHandler.queue.value;
  //   _audioHandler.mediaItem.listen((mediaitem) {
  //     detailMusicNotifier.value =
  //         mediaitem ?? const MediaItem(id: '-1', title: '');

  //     if (playlist.isEmpty || mediaitem == null) {
  //       isfirstone.value = true;
  //       isLastOne.value = true;
  //     } else {
  //       isfirstone.value = playlist.first == mediaitem;
  //       isLastOne.value = playlist.last == mediaitem;
  //     }
  //   });
  // }
  void onShufflePressed() {
    if (shuffleModeNotifier.value == false) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
      shuffleModeNotifier.value = true;
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
      repeate.value = RepeatState.off;
    } else {
      shuffleModeNotifier.value = false;
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
      repeate.value = RepeatState.all;
    }
  }

  void onSkipPressed() {
    _audioHandler.skipToNext();
  }

  void onPreviousPressed() {
    _audioHandler.skipToPrevious();
  }

  // void _listenToplaybackstate() {
  //   _audioHandler.playbackState.listen((playbackstate) {
  //     final isPlaying = playbackstate.playing;
  //     final processingState = playbackstate.processingState;
  //     if (processingState == AudioProcessingState.loading ||
  //         processingState == AudioProcessingState.buffering) {
  //       bttonStateNotifier.value = ButtonState.load;
  //     } else if (isPlaying) {
  //       bttonStateNotifier.value = ButtonState.paused;
  //     } else if (processingState != AudioProcessingState.completed) {
  //       bttonStateNotifier.value = ButtonState.play;
  //     } else {
  //       _audioHandler.seek(Duration.zero);
  //       _audioHandler.pause();
  //     }
  //   });
  // }
  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen(
      (playbackState) {
        final isPlaying = playbackState.playing;
        final processingState = playbackState.processingState;
        if (processingState == AudioProcessingState.loading ||
            processingState == AudioProcessingState.buffering) {
          processingState == AudioProcessingState.loading;
        } else if (!isPlaying) {
          bttonStateNotifier.value = ButtonState.paused;
        } else if (processingState != AudioProcessingState.completed) {
          bttonStateNotifier.value = ButtonState.play;
        } else {
          _audioHandler.seek(Duration.zero);
          _audioHandler.pause();
        }
      },
    );
  }

  // _listenToCurrentPosition() {
  //   AudioService.position.listen((position) {
  //     final oldState = progressBarNotifier.value;
  //     progressBarNotifier.value = ProgressBarState(
  //         buffered: oldState.buffered,
  //         current: position,
  //         total: oldState.total);
  //   });
  // }

  // _listenToBufferedPosition() {
  //   _audioHandler.playbackState.listen((position) {
  //     final oldState = progressBarNotifier.value;
  //     progressBarNotifier.value = ProgressBarState(
  //         buffered: position.bufferedPosition,
  //         current: oldState.current,
  //         total: oldState.total);
  //   });
  // }

  // _listenToTotalPosition() {
  //   _audioHandler.mediaItem.listen((position) {
  //     final oldState = progressBarNotifier.value;
  //     progressBarNotifier.value = ProgressBarState(
  //         buffered: oldState.buffered,
  //         current: oldState.current,
  //         total: position!.duration ?? Duration.zero);

  //     ///
  //   });
  // }

  // void onVolumePressed() {
  //   if (volumeStateNotifier.value != 0) {
  //     _audioHandler.androidSetRemoteVolume(0);

  //     volumeStateNotifier.value = 0;
  //   } else {
  //     _audioHandler.androidSetRemoteVolume(1);
  //     volumeStateNotifier.value = 1;
  //   }
  // }

  void onRepeatPressed() {
    repeate.nextState();
    if (repeate.value == RepeatState.off) {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);

      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else if (repeate.value == RepeatState.all) {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
    } else if (repeate.value == RepeatState.one) {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
    }
  }

  void seek(position) {
    _audioHandler.seek(position);
  }

  void playfromPlaylist(int index) {
    _audioHandler.skipToQueueItem(index);
  }
}

class ProgressBarState {
  final Duration current;
  final Duration total;
  final Duration buffered;

  ProgressBarState(
      {required this.buffered, required this.current, required this.total});
}

enum ButtonState { play, paused, load }

enum RepeatState { all, one, off }

class RepeatStateNotifier extends ValueNotifier<RepeatState> {
  RepeatStateNotifier() : super(initialValue);
  static const initialValue = RepeatState.all;
  void nextState() {
    var next = (value.index + 1) % RepeatState.values.length;
    value = RepeatState.values[next];
  }
}

// void _listenChangePlayerState() {
  //   _audioPlayer.playerStateStream.listen((playerState) {
  //     final playing = playerState.playing;
  //     final proccesingState = playerState.processingState;
  //     if (proccesingState == ProcessingState.loading ||
  //         proccesingState == ProcessingState.buffering) {
  //       bttonStateNotifier.value = ButtonState.load;
  //     } else if (!playing) {
  //       bttonStateNotifier.value = ButtonState.paused;
  //     } else if (proccesingState == ProcessingState.completed) {
  //       _audioPlayer.stop();
  //       bttonStateNotifier.value = ButtonState.paused;
  //     } else {
  //       bttonStateNotifier.value = ButtonState.play;
  //     }
  //   });
  // }
  // void setPlayList() {
  //   const prefix = 'assest/images';
    // final song1 = Uri.parse(
    //     'https://ts9.tarafdari.com/contents/user627598/content-sound/aud-20210403-wa0001.mp3');
    // final song2 = Uri.parse(
    //     'https://dl.baarzesh.net/music/2019/201911/Tones_And_I_Dance_Monkey_320.mp3');
    // final song3 = Uri.parse(
    //     'https://dls.music-fa.com/tagdl/downloads/Iman%20Fallah%20-%20Jane%20Mar%20(128).mp3');
    // final song4 = Uri.parse(
    //     'https://dls.music-fa.com/tagdl/ali/Behnam%20Bani%20-%202ta%20Dele%20Ashegh%20(320).mp3');
    // final song5 = Uri.parse(
    //     'https://dlmain.gandommusic.ir/mp3/1/Scriptonite%20-%20Dioronabeat%20%D0%BF%D0%BE%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20%28%20Remix%20%29%20%28%20GandomMusic.ir%20%29.mp3');
    // _playlist = ConcatenatingAudioSource(children: [
    //   AudioSource.uri(song1,
    //       tag: InfoMusic(
    //           artist: 'Rihanna',
    //           title: 'Diamonds',
    //           assestImage: '$prefix/reyhanna.png')),
    //   AudioSource.uri(song2,
    //       tag: InfoMusic(
    //           artist: 'Tones and I',
    //           title: 'DanceMonkey',
    //           assestImage: '$prefix/monkey.jpg')),
    //   AudioSource.uri(song3,
    //       tag: InfoMusic(
    //           artist: 'iman fallah',
    //           title: 'jane mar',
    //           assestImage: '$prefix/iman.jpg')),
    //   AudioSource.uri(song4,
    //       tag: InfoMusic(
    //           artist: 'Behnam Bani',
    //           title: 'دوتادل عاشق',
    //           assestImage: '$prefix/bani.jpg')),
    //   AudioSource.uri(song5,
    //       tag: InfoMusic(
    //           artist: 'dior',
    //           title: 'положение',
    //           assestImage: '$prefix/diro.jpg')),
    // ]);
    // if (_audioPlayer.bufferedPosition == Duration.zero) {
    //   _audioPlayer.setAudioSource(_playlist);
    // } else {}
  // }

  // void listenChangeProgressBar() {
  //   _audioPlayer.durationStream.listen((position) {
  //     final oldState = progressBarNotifier.value;
  //     progressBarNotifier.value = ProgressBarState(
  //         buffered: oldState.buffered,
  //         progress: oldState.progress,
  //         total: position ?? Duration.zero);
  //   });
  //   _audioPlayer.positionStream.listen((position) {
  //     final oldState = progressBarNotifier.value;
  //     progressBarNotifier.value = ProgressBarState(
  //         buffered: oldState.buffered,
  //         progress: position,
  //         total: oldState.total);
  //   });
  //   _audioPlayer.bufferedPositionStream.listen((position) {
  //     final oldState = progressBarNotifier.value;
  //     progressBarNotifier.value = ProgressBarState(
  //         buffered: position,
  //         progress: oldState.progress,
  //         total: oldState.total);
  //   });
  // }

  // void _listenSequenceState() {
  //   _audioPlayer.sequenceStateStream.listen((sequence) {
  //     if (sequence == null) return;
  //     final currentItem = sequence.currentSource;
  //     final song = currentItem!.tag as InfoMusic;
  //     detailMusic.value = song;
  //     final playListmusic = sequence.effectiveSequence;
  //     final info = playListmusic.map((song) {
  //       return song.tag as InfoMusic;
  //     }).toList();
  //     playList.value = info;
  //     //firstOrLast
  //     if (playListmusic.isEmpty || currentItem == null) {
  //       isfirstone.value = true;
  //       isLastOne.value = true;
  //     } else {
  //       isfirstone.value = currentItem == playListmusic.first;
  //       isLastOne.value = currentItem == playListmusic.last;
  //     }
  //   });
  // }




  