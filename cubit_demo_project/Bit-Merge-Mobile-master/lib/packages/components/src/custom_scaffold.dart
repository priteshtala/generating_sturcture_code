import 'package:bit_merge_mobile/packages/components/components.dart';
import 'package:bit_merge_mobile/packages/resources/resources.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String? bgImagePath;
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  const CustomScaffold({
    super.key,
    this.bgImagePath,
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const SvgImageFromAsset(
            AppVectors.bgPattern,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            body: body,
          ),
        ],
      ),
    );
  }
}
