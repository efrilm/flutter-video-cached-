import 'package:equatable/equatable.dart';

import '../../models/video.dart';

abstract class VideoPlayerEvent extends Equatable {
  @override
  List<Object> get props => const [];
}

class VideoSelectedEvent extends VideoPlayerEvent {
  final Video video;

  VideoSelectedEvent(this.video);

  @override
  List<Object> get props => [video];
}
