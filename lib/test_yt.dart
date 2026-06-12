import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  var controller = YoutubePlayerController.fromVideoId(
    videoId: 'abc',
    autoPlay: true,
    params: const YoutubePlayerParams(mute: false),
  );
  controller.loadVideoById(videoId: 'def');
  controller.close();
}
