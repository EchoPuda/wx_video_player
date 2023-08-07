import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wx_video_player/TestPage.dart';
import 'package:wx_video_player/drag_bottom_dismiss/drag_bottom_dismiss_dialog.dart';
import 'package:wx_video_player/video_player/video_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Video Play Demo'),
    );
  }
}


/// 建议封装在一个小组件里
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String videoUrl = "https://jomin-web.web.app/resource/video/video_iu.mp4";
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await _videoPlayerController.initialize();
    // 设置循环
    _videoPlayerController.setLooping(true);
    // 播放
    await _videoPlayerController.play();

    // 初始化完成，刷新，初始化完成才能显示VideoPlayer
    // if (mounted) {
    //   setState(() {});
    // }
  }

  void onTap() {
    Navigator.push(
      context,
      DragBottomDismissDialog(
        builder: (context) {
          return VideoPage(
            videoPlayerController: _videoPlayerController,
            heroTag: "video_page_player",
          );
        },
      ),
    ).then((value) {
      _videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(onTap: onTap, child: Text(widget.title)),
      ),
      body: Hero(
        tag: 'video_page_player',
        child: Stack(
          children: [
            SizedBox(
              width: 200,
              child: AspectRatio(
                aspectRatio:
                _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(
                  _videoPlayerController,
                ),
              ),
            ),

            Positioned.fill(
              child: GestureDetector( // VideoPlayer 捕获了点击事件，并且优先级较高，所以盖在上面才能拿到点击事件
                onTap: () {
                  onTap();
                },
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
