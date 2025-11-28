import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/disabled_wrapper.dart';

class CardContainer extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final bool disabled;

  const CardContainer({Key? key, this.child, this.onTap, this.disabled = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisabledWrapper(
      disabled: disabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.fromBorderSide(
                BorderSide(width: 1, color: AppTheme.lightGrey(context)),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
