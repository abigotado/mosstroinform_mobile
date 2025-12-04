import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

abstract class AppAnimatedSwitcherWidget extends StatelessWidget {
  const AppAnimatedSwitcherWidget({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 300),
  });

  final Widget child;
  final Duration duration;
}

class AppAnimatedSwitcher extends AppAnimatedSwitcherWidget {
  const AppAnimatedSwitcher({
    required super.child,
    super.key,
    super.duration,
    this.transitionBuilder,
    this.layoutBuilder,
  });

  final Widget Function(Widget, Animation<double>)? transitionBuilder;
  final AnimatedSwitcherLayoutBuilder? layoutBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: layoutBuilder ?? AnimatedSwitcher.defaultLayoutBuilder,
      duration: duration,
      transitionBuilder:
          transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,
      child: child,
    );
  }
}

class AppSliverAnimatedSwitcher extends AppAnimatedSwitcherWidget {
  const AppSliverAnimatedSwitcher({
    required final Widget sliver,
    super.key,
    super.duration,
  }) : super(child: sliver);

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedSwitcher(duration: duration, child: child);
  }
}
