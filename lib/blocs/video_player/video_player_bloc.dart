import 'package:bloc/bloc.dart';

import '../../services/video_controller_service.dart';
import 'video_player_event.dart';
import 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final VideoControllerService _videoControllerService;

  VideoPlayerBloc(this._videoControllerService) : super(VideoPlayerStateInitial()) {
    on<VideoPlayerEvent>((event, emit) async {
      if (event is VideoSelectedEvent) {
        emit(VideoPlayerStateLoading());
        try {
          final videoController = await _videoControllerService.getControllerForVideo(event.video);
          emit(VideoPlayerStateLoaded(event.video, videoController));
        } catch (e) {
          emit(VideoPlayerStateError('An unknown error occurred'));
        }
      }
    });
  }

  Stream<VideoPlayerState> mapEventToState(VideoPlayerEvent event) async* {}
}
