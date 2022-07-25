import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:music_player/Controllers/page_manager.dart';
import 'package:music_player/services/audio_handler.dart';
import 'package:music_player/services/playlist_repository.dart';

GetIt getIt = GetIt.instance;

Future setupInitService() async {
  getIt.registerSingleton<AudioHandler>(await initaudioService());
  getIt.registerLazySingleton<PlayListRepository>(() => MyPlayList());
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
