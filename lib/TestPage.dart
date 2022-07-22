import 'package:flutter/material.dart';
import 'package:wx_video_player/drag_bottom_dismiss/drag_bottom_pop_sheet.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: DragBottomPopGesture(
          child: Hero(
            tag: "test_tag",
            child: Container(
              width: double.maxFinite,
              height: 400,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
