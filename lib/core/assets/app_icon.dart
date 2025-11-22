import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconPaths {
  static const base = 'assets/icons';
  static const extension = 'svg';

  static getPath(String name) {
    return '${base}/${name}.${extension}';
  }

  static final fire = getPath('fire');
  static final heartMonitor = getPath('heart_monitor');
  static final heartRate = getPath('heart_rate');
  static final moon = getPath('moon');
  static final star = getPath('star');
  static final steps = getPath('steps');
  static final timer = getPath('timer');
}

class AppIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color? color;

  const AppIcon(
    this.asset, {
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
