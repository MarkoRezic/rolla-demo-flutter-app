import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/containers/disabled_wrapper.dart';

class CardContainer extends StatelessWidget {

  const CardContainer({super.key, this.child, this.onTap, this.disabled = false});
  final Widget? child;
  final VoidCallback? onTap;
  final bool disabled;

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
                BorderSide(color: AppTheme.lightGrey(context)),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
