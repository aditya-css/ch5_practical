import 'package:flutter/material.dart';

class LoadingImage extends StatefulWidget {
  const LoadingImage({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width, height;

  @override
  State<LoadingImage> createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animStart;
  late Animation<Color?> _animEnd;

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
      child: Container(
        height: widget.height,
        width: widget.width,
        color: Colors.white,
      ),
    );
  }
}
