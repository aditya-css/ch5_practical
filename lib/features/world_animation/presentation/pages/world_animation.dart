import 'package:ch5_practical/core/utilities.dart';
import 'package:ch5_practical/features/home_article_fetch/presentation/mobx/bottom_nav_index_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class WorldBarPage extends StatefulWidget {
  const WorldBarPage({Key? key}) : super(key: key);

  @override
  _WorldBarPageState createState() => _WorldBarPageState();
}

class _WorldBarPageState extends State<WorldBarPage>
    with SingleTickerProviderStateMixin {
  Size get _size => MediaQuery.of(context).size;

  double get _widthSmall => _size.width * 0.6;

  double get _heightSmall => _size.height * 0.4;

  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavStore>(
      builder: (_, store, __) => Observer(
        builder: (_) {
          if (store.index == worldIndex) {
            Future.delayed(
              const Duration(milliseconds: 1200),
              () {
                if (!_controller.isAnimating) {
                  return _controller.repeat();
                }
              },
            );
          } else {
            _controller.stop();
          }
          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInQuart,
              height: (store.index == worldIndex) ? _size.height : _heightSmall,
              width: (store.index == worldIndex) ? _size.width : _widthSmall,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                image: DecorationImage(
                  image: AssetImage(starsBackgroundSrc),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(
                  (store.index == worldIndex) ? 0 : 22,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SafeArea(
                      child: SizedBox(
                        width: _widthSmall - 40,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInBack,
                          opacity: (store.index == worldIndex) ? 0 : 1,
                          child: const Text(
                            'Take a Peek into the Space.',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeInQuart,
                      scale: (store.index == worldIndex) ? 1 : 0,
                      child: RotationTransition(
                        turns: _controller,
                        child: Image.asset(
                          moonSrc,
                          height: _size.height * 0.4,
                          width: _size.width * 0.7,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
