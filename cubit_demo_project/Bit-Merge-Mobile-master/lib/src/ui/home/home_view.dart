import 'package:bit_merge_mobile/packages/components/components.dart';
import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/data/data.dart';
import 'package:bit_merge_mobile/packages/resources/resources.dart';
import 'package:bit_merge_mobile/src/app/dependency.dart';
import 'package:bit_merge_mobile/theme/theme_bloc.dart';
import 'package:bit_merge_mobile/theme/theme_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

part 'home_cubit.dart';

part 'home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = "/home";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context, const HomeState()),
      child: const HomeView(),
    );
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
          child: Column(
            children: [
              const Expanded(flex: 3, child: _TopFirstView()),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Material(
                      color: context.colorScheme.background.withOpacity(0.3),
                      borderRadius: ShapeBorderRadius.medium,
                      child: const Padding(
                        padding: PaddingValue.xLarge,
                        child: Column(
                          children: [
                            CommonText.medium(
                              "Highest Score",
                              size: 28,
                            ),
                            Gap(Spacing.xLarge),
                            CommonText.medium(
                              "2048",
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: SvgImageFromAsset(
                        CommonIcons.play,
                        width: context.width * 0.4,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              BlocSelector<HomeCubit, HomeState, bool>(
                selector: (state) => state.isLightTheme,
                builder: (context, state) {
                  return PrimaryButton(
                    onPressed: () {
                      context.read<HomeCubit>().onThemeChanged(isLightTheme: !state);
                    },
                    label: "Theme",
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TopFirstView extends StatelessWidget {
  const _TopFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(Spacing.small),
        FittedBox(
          child: Row(
            children: [
              const _TopView(icon: CommonIcons.coin, value: "1,000"),
              const Gap(Spacing.large),
              const _TopView(icon: CommonIcons.energy, value: "15/15"),
              const Gap(Spacing.large * 2),
              CustomIconButton(
                onPressed: () {},
                iconPath: CommonIcons.mail,
              ),
              const Gap(Spacing.large),
              CustomIconButton(
                onPressed: () {},
                iconPath: CommonIcons.setting,
                size: 24,
              ),
            ],
          ),
        ),
        const Gap(Spacing.xLarge * 2),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                const SvgImageFromAsset(CommonIcons.spin),
                const Gap(Spacing.small),
                Material(
                  color: context.colorScheme.background.withOpacity(0.5),
                  borderRadius: ShapeBorderRadius.small,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.xSmall),
                    child: CommonText.medium(
                      "23:59:08",
                      textAlign: TextAlign.center,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TopView extends StatelessWidget {
  final String icon;
  final String value;

  const _TopView({super.key, required this.icon, required this.value});

  final double iconSize = 36.0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: context.width * 0.2,
        maxWidth: context.width * 0.3,
        minHeight: 36,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Material(
            color: context.colorScheme.background.withOpacity(0.5),
            borderRadius: ShapeBorderRadius.large,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(Spacing.small),
                  CommonText.medium(
                    value,
                    textAlign: TextAlign.center,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: SvgImageFromAsset.square(
              icon,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
