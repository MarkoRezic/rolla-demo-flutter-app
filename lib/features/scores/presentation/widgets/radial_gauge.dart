import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';

class RadialGauge extends StatelessWidget {
  final int value;
  final String type;
  const RadialGauge({Key? key, required this.value, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.accentFor(type);
    return SizedBox(
      height: 180,
      width: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 180,
            width: 180,
            child: CircularProgressIndicator(
              value: value / 100,
              strokeWidth: 18,
              color: accent,
              backgroundColor: Theme.of(context).dividerColor,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$value', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text('Score', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
