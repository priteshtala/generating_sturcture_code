import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bit_merge_mobile/packages/components/components.dart';
import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/resources/resources.dart';
import 'package:bit_merge_mobile/src/ui/auth/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = "/splash";

  static Widget builder(BuildContext context) => const SplashView();

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _splashAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

  late final AnimationController _loaderAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
        ..addListener(() {
          if (_loaderAnimationController.isCompleted) {
            context.navigator.pushNamed(AuthView.routeName);
          }
        });

  late final Animation<double> _imageSizeController =
      CurvedAnimation(parent: _splashAnimationController, curve: Curves.bounceInOut)
        ..addListener(() {
          if (_imageSizeController.isCompleted) {
            _loaderAnimationController.forward();
          }
        });

  @override
  void initState() {
    _splashAnimationController.forward(from: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_imageSizeController, _loaderAnimationController]),
        builder: (context, child) {
          final imageSize = ((MediaQuery.of(context).size.shortestSide * 0.6).floorToDouble());
          final animatingImageSize = _imageSizeController.value * imageSize;
          final logoTopPosition = ((context.height) / 2) - animatingImageSize / 1.25;
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: logoTopPosition,
                child: Column(
                  children: [
                    SvgImageFromAsset.square(
                      AppImages.appLogo,
                      size: animatingImageSize,
                    ),
                    const Gap(Spacing.xLarge * 2),
                    AnimatedOpacity(
                      opacity: _splashAnimationController.isCompleted ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Column(
                        children: [
                          SizedBox(
                            width: context.width * 0.6,
                            child: LinearProgressIndicator(
                              value: _loaderAnimationController.value,
                              minHeight: 18,
                              color: context.colorScheme.secondary,
                              borderRadius: ShapeBorderRadius.large,
                            ),
                          ),
                          if (_splashAnimationController.isCompleted) ...[
                            const Gap(Spacing.medium),
                            AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText(
                                  "Loading...",
                                  textStyle: TextStyle(
                                    color: context.colorScheme.onSecondary,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                  speed: const Duration(milliseconds: 100),
                                ),
                              ],
                              repeatForever: true,
                            )
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
