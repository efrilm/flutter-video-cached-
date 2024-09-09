import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/video_player/video_player_bloc.dart';
import '../blocs/video_player/video_player_event.dart';
import '../blocs/video_player/video_player_state.dart';
import '../models/video.dart';
import '../services/video_controller_service.dart';
import '../widgets/video_player_widget.dart';

class VideoPage extends StatelessWidget {
  final Video video;

  const VideoPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildVideoPlayer(),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return BlocProvider<VideoPlayerBloc>(
      create: (context) =>
          VideoPlayerBloc(RepositoryProvider.of<VideoControllerService>(context))..add(VideoSelectedEvent(video)),
      child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[_getPlayer(context, state)],
          );
        },
      ),
    );
  }

  Widget _getPlayer(BuildContext context, VideoPlayerState state) {
    if (state is VideoPlayerStateLoaded) {
      return VideoPlayerWidget(
        key: Key(state.video.url),
        videoTitle: state.video.title,
        controller: state.controller,
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenWidth / ASPECT_RATIO;

    if (state is VideoPlayerStateError) {
      return Container(
        height: 200,
        color: Colors.grey,
        child: Center(
          child: Text(state.message),
        ),
      );
    }

    return Container(
      height: 200,
      color: Colors.grey,
      child: const Center(
        child: Text('Initialising video...'),
      ),
    );
  }
}
