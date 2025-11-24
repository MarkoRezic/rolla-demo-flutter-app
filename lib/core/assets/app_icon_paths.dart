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
  static final settings = getPath('settings');
  static final star = getPath('star');
  static final steps = getPath('steps');
  static final timer = getPath('timer');
}
