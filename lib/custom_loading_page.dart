import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animStart;
  late Animation<Color?> _animEnd;

  Column get _textBox => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            width: 150,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 8,
            width: 100,
            color: Colors.white,
          ),
        ],
      );

  Container get _imageBox => Container(
        height: 150,
        width: 150,
        color: Colors.white,
      );

  Container get _catTextBox => Container(
        height: 55,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 16.0,
        ),
        child: Container(color: Colors.white),
      );

  Row get _categoryBox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _catTextBox,
          const Text(
            '...',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          _catTextBox,
        ],
      );

  Column get _verticalArticle => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageBox,
          const SizedBox(height: 8.0),
          _textBox,
        ],
      );

  Row get _horizontalArticle => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageBox,
          const SizedBox(width: 8.0),
          Column(
            children: [
              _textBox,
              const SizedBox(height: 16.0),
              _textBox,
              const SizedBox(height: 16.0),
              _textBox,
            ],
          ),
        ],
      );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);

    _animStart = ColorTween(
      begin: Colors.grey.withOpacity(0.3),
      end: Colors.grey.withOpacity(0.8),
    ).animate(_controller);

    _animEnd = ColorTween(
      begin: Colors.grey.withOpacity(0.8),
      end: Colors.grey.withOpacity(0.3),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [_animStart.value!, _animEnd.value!],
      ).createShader(rect),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _categoryBox,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _verticalArticle,
                const Text(
                  '...',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                _verticalArticle,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _horizontalArticle,
                const SizedBox(height: 16),
                _horizontalArticle,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
