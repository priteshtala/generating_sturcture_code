import 'package:bit_merge_mobile/packages/components/components.dart';
import 'package:bit_merge_mobile/packages/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final String content;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? radius;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.content = '',
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.radius,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _Button(
      textColor: textColor,
      label: label,
      content: content,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(radius ?? 14),
      padding: padding,
      icon: icon,
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final String iconPath;
  final double size;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.iconPath,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SvgImageFromAsset.square(
            AppVectors.iconButtonBg,
            size: 50,
          ),
          SvgImageFromAsset.square(
            iconPath,
            size: size,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final String content;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final BorderSide? border;
  final BorderRadiusGeometry? borderRadius;
  final Widget? icon;

  const _Button({
    required this.onPressed,
    required this.label,
    this.content = '',
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.fontWeight,
    this.padding,
    this.border,
    this.fontSize,
    this.borderRadius,
    this.icon,
  });

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> with SingleTickerProviderStateMixin {
  double _scale = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller.forward(from: 0);
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse(from: 0.05);
      },
      child: Transform.scale(
        scale: _scale,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              gradient: widget.backgroundColor == null
                  ? const LinearGradient(
                      colors: [
                        Color(0xFF19B395),
                        Color(0xFF1DCFAC),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(14),
              border: Border.fromBorderSide(widget.border ?? BorderSide.none),
            ),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        widget.icon!,
                        const Gap(10),
                      ],
                      CommonText.medium(
                        widget.label,
                        size: widget.fontSize ?? 16,
                        color: widget.textColor,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  if (widget.content.isNotEmpty) ...[
                    CommonText(
                      widget.content,
                      size: 12,
                      color: widget.textColor ?? Colors.white,
                      fontWeight: widget.fontWeight ?? FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final void Function()? onPressed;

  const GoogleButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      label: 'Continue with Google',
      icon: const SvgImageFromAsset.square(
        CommonIcons.google,
      ),
    );
  }
}
