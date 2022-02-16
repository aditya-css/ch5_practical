import 'package:ch5_practical/custom_shimmer_effect.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, this.showHalf = false}) : super(key: key);
  final bool showHalf;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double get _width4 => MediaQuery.of(context).size.width * 0.4;

  Widget get _textBox => ShimmerEffect(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 8,
              color: Colors.white,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    height: 8,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      );

  Widget get _imageBox => ShimmerEffect(
        Container(
          height: _width4,
          width: _width4,
          color: Colors.white,
        ),
      );

  Widget get _catTextBox => ShimmerEffect(
        Container(
          height: 55,
          width: _width4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 16.0,
          ),
          child: Container(color: Colors.white),
        ),
      );

  Row get _categoryBox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_catTextBox, _catTextBox],
      );

  Column get _verticalArticle => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageBox,
          const SizedBox(height: 8.0),
          SizedBox(height: 30, width: _width4, child: _textBox),
        ],
      );

  Row get _horizontalArticle => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageBox,
          const SizedBox(width: 8.0),
          SizedBox(
            height: 140,
            width: _width4,
            child: Column(
              children: [
                _textBox,
                const SizedBox(height: 16.0),
                _textBox,
                const SizedBox(height: 16.0),
                _textBox,
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!widget.showHalf)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _categoryBox,
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_verticalArticle, _verticalArticle],
          ),
        ),
        if (!widget.showHalf)
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
    );
  }
}
