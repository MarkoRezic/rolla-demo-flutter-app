import 'package:flutter/material.dart';

class DisabledWrapper extends StatelessWidget {
  final bool disabled;
  final Widget child;

  const DisabledWrapper({
    super.key,
    required this.disabled,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!disabled) return child;

    return IgnorePointer(
      child: Opacity(
        opacity: 0.7,
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: child,
        ),
      ),
    );
  }
}
