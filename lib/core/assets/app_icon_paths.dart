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

  // Activities
  static final cardio = getPath('cardio');
  static final cycling = getPath('cycling');
  static final dance = getPath('dance');
  static final hiit = getPath('hiit');
  static final hiking = getPath('hiking');
  static final intervals = getPath('intervals');
  static final pilates = getPath('pilates');
  static final running = getPath('running');
  static final strength_training = getPath('strength_training');
  static final swimming = getPath('swimming');
  static final walking = getPath('walking');
  static final yoga = getPath('yoga');
}
