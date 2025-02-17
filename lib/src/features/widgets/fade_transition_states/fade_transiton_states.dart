import 'package:flutter/material.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';

class FadetransitonStates extends StatelessWidget {
  const FadetransitonStates({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Constants.animationTransition,
      reverseDuration: Constants.animationTransition,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          alwaysIncludeSemantics: false,
          child: child,
        );
      },
      child: child,
    );
  }
}
