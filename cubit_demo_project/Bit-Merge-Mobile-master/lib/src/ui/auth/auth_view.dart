import 'package:bit_merge_mobile/packages/components/components.dart';
import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/resources/resources.dart';
import 'package:bit_merge_mobile/src/ui/home/home_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

part 'auth_cubit.dart';

part 'auth_state.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  static const routeName = "/auth";

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(context, AuthState()),
      child: const AuthView(),
    );
  }

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    final imageSize = ((MediaQuery.of(context).size.shortestSide * 0.5).floorToDouble());

    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgImageFromAsset.square(
            AppImages.appLogo,
            size: imageSize,
          ),
          const Spacer(flex: 2),
          SafeArea(
            top: false,
            bottom: false,
            minimum: PaddingValue.medium,
            child: GoogleButton(onPressed: context.read<AuthCubit>().onGoogleLogin),
          ),
          const Gap(Spacing.large),
          const TermsSection(),
          const Spacer(),
        ],
      ),
    );
  }
}

class TermsSection extends StatelessWidget {
  const TermsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(Spacing.large),
        Theme(
          data: context.theme.copyWith(unselectedWidgetColor: Colors.transparent),
          child: SizedBox(
            height: 24,
            width: 24,
            child: BlocSelector<AuthCubit, AuthState, bool>(
              selector: (state) => state.checkTerms,
              builder: (context, checkTerms) {
                return Checkbox(
                  value: checkTerms,
                  onChanged: context.read<AuthCubit>().onSelectTerms,
                );
              },
            ),
          ),
        ),
        const Gap(Spacing.small),
        Expanded(
          child: LinkText(
            listSpan: [
              const LinkTextSpan(text: 'By clicking continue you agree with our '),
              LinkTextSpan(text: 'Terms and conditions', onPressed: () {}),
              const LinkTextSpan(text: ' and our '),
              LinkTextSpan(text: 'Privacy policy.', onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
