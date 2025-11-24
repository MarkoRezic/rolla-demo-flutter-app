import 'package:flutter/material.dart';

import 'app_icon.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final double? size;
  final Color? color;

  /// Main constructor: takes ANY widget as icon
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size,
    this.color,
  });

  /// Convenience constructor for internal icon assets
  ///
  /// Example:
  /// AppIconButton.asset(AppIcons.fire, onPressed: () {})
  factory AppIconButton.asset(
    String assetPath, {
    Key? key,
    required VoidCallback onPressed,
    double size = 24,
    Color? color,
  }) {
    return AppIconButton(
      key: key,
      onPressed: onPressed,
      size: size,
      color: color,
      icon: AppIcon(assetPath, size: size, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: size ?? 24,
      icon: icon,
      color: color,
    );
  }
}
