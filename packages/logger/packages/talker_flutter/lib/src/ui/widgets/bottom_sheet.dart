import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    required this.talkerScreenTheme,
    required this.child,
    required this.title,
    super.key,
    this.heightFactor,
  });

  final TalkerScreenTheme talkerScreenTheme;
  final Widget child;
  final String title;
  final double? heightFactor;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.only(
          top: mq.padding.top + mq.viewInsets.top + 50,
        ),
        padding: const EdgeInsets.only(
          top: 20,
        ),
        decoration: BoxDecoration(
          color: talkerScreenTheme.backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(color: talkerScreenTheme.textColor, fontSize: 28),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        color: talkerScreenTheme.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
