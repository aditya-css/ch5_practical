import 'package:ch5_practical/extensions.dart';
import 'package:ch5_practical/flavour_config.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

class SettingsBarPage extends StatefulWidget {
  const SettingsBarPage({Key? key}) : super(key: key);

  @override
  State<SettingsBarPage> createState() => _SettingsBarPageState();
}

class _SettingsBarPageState extends State<SettingsBarPage>
    with TickerProviderStateMixin {
  late final AnimationController _transitionController;
  late final AnimationController _initController;

  late final Animation<double> _initAnim;

  ScreenState _curState = ScreenState.home;

  Animation<RelativeRect> get _transitionRectAnim => RelativeRectTween(
        begin: RelativeRect.fromLTRB(
          _size.width * 0.75,
          _size.height * 0.65,
          -_size.width * 0.25,
          _size.height * 0.1,
        ),
        end: RelativeRect.fromLTRB(
          -_size.width * 0.6,
          -_size.height * 0.45,
          -_size.width * 0.4,
          -_size.height * 0.25,
        ),
      ).animate(
        CurvedAnimation(
          parent: _transitionController,
          curve: Curves.easeInOutQuart,
        ),
      );

  Size get _size => MediaQuery.of(context).size;

  double get _showBody => (_curState == ScreenState.home) ? 0 : 1;

  double get _showArrow => (_curState == ScreenState.home) ? 1 : 0;

  double get _bodyLeftAlign => (_curState == ScreenState.home)
      ? -(_size.width * 0.7)
      : _size.width * 0.1;

  double get _boxLeftAlign => (_curState == ScreenState.home) ? 40 : _width35;

  double get _boxBottomAlign => (_curState == ScreenState.home) ? 0 : _height25;

  double get _rotateAngle => 190.08;

  double get _boxSize => 20;

  double get _height1 => _size.height * 0.1;

  double get _height3 => _size.height * 0.3;

  double get _height25 => _size.height * 0.25;

  double get _height35 => _size.height * 0.35;

  double get _height58 => _size.height * 0.58;

  double get _width3 => _size.width * 0.3;

  double get _width35 => _size.width * 0.35;

  double get _width5 => _size.width * 0.5;

  void _handleStateChange() {
    if (_curState == ScreenState.home) {
      _transitionController.forward();
      _initController.reverse();
    } else {
      _transitionController.reverse().whenComplete(
            () => _initController.forward(),
          );
    }
    setState(() {
      (_curState == ScreenState.home)
          ? _curState = ScreenState.info
          : _curState = ScreenState.home;
    });
  }

  @override
  void initState() {
    _transitionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: AnimSpeed.fast.value),
    );

    _initController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: AnimSpeed.normal.value),
      reverseDuration: Duration(milliseconds: AnimSpeed.veryFast.value),
    );

    _initAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _initController,
        curve: Curves.easeInOutQuart,
      ),
    );

    _initController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox.expand(
          child: Stack(
            children: [
              const Positioned(
                top: 10,
                left: 40,
                child: SafeArea(
                  child: Text(
                    'Adi\ncss',
                    style: TextStyle(
                      fontSize: 32,
                      height: 1,
                      fontFamily: 'Times',
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 55,
                child: SafeArea(
                  child: Transform.rotate(
                    angle: _rotateAngle,
                    child: const Text(
                      ')',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        fontFamily: 'Times',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _height25,
                right: 40,
                child: ScaleTransition(
                  scale: _initAnim,
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: FittedBox(
                      child: Text(
                        '.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 0.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _height35,
                left: 40,
                child: SizedBox(
                  height: _height3,
                  width: _width5,
                  child: const FittedBox(
                    child: Text(
                      'Wel\ncome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1,
                        fontFamily: 'Times',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _height58,
                left: _width3,
                child: Transform.rotate(
                  angle: _rotateAngle,
                  child: SizedBox(
                    height: 80,
                    child: ScaleTransition(
                      scale: _initAnim,
                      child: const FittedBox(
                        child: Text(
                          ')',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontFamily: 'Times',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: AnimSpeed.slow.value),
                curve: Curves.bounceOut,
                left: _boxLeftAlign,
                bottom: _boxBottomAlign,
                child: Container(
                  color: FlavourConfig.instance.colorScheme.background,
                  width: _boxSize,
                  height: _boxSize,
                ),
              ),
              PositionedTransition(
                rect: _transitionRectAnim,
                child: GestureDetector(
                  onTap: () => _handleStateChange(),
                  child: CircleAvatar(
                    backgroundColor:
                        FlavourConfig.instance.colorScheme.secondary,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: AnimatedOpacity(
                          opacity: _showArrow,
                          duration:
                              Duration(milliseconds: AnimSpeed.veryFast.value),
                          curve: Curves.fastOutSlowIn,
                          child: const Icon(
                            Icons.arrow_forward_sharp,
                            size: 42,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: AnimSpeed.normal.value),
                curve: Curves.easeInOutQuart,
                left: _bodyLeftAlign,
                top: _height1,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: AnimSpeed.veryFast.value),
                  curve: Curves.fastOutSlowIn,
                  opacity: _showBody,
                  child: GestureDetector(
                    onTap: () => _handleStateChange(),
                    child: SizedBox(
                      height: _size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 3,
                            child: SizedBox(
                              height: 120,
                              width: 180,
                              child: FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hello,',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${FlavourConfig.instance.greeting}! ',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          FlavourConfig.instance.icon,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                          Flexible(
                            flex: 4,
                            child: SizedBox(
                              width: 240,
                              child: Text(
                                FlavourConfig.instance.description,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                          if (FlavourConfig.isProd)
                            Flexible(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: FlavourConfig
                                      .instance.colorScheme.onBackground,
                                ),
                                child: Text(
                                  'Feedback',
                                  style: TextStyle(
                                    color: FlavourConfig
                                        .instance.colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
