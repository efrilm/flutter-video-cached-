// ignore_for_file: avoid_print

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:pedantic/pedantic.dart';

import '../models/video.dart';

abstract class VideoControllerService {
  Future<VideoPlayerController> getControllerForVideo(Video video);
}

class CachedVideoControllerService extends VideoControllerService {
  final BaseCacheManager _cacheManager;

  CachedVideoControllerService(this._cacheManager);

  @override
  Future<VideoPlayerController> getControllerForVideo(Video video) async {
    final fileInfo = await _cacheManager.getFileFromCache(video.url);

    if (fileInfo == null) {
      print('[VideoControllerService]: No video in cache');

      print('[VideoControllerService]: Saving video to cache');
      unawaited(_cacheManager.downloadFile(video.url));

      return VideoPlayerController.networkUrl(Uri.parse(video.url));
    } else {
      print('[VideoControllerService]: Loading video from cache');
      return VideoPlayerController.file(fileInfo.file);
    }
  }
}
