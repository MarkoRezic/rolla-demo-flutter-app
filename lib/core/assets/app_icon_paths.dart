class AppIconPaths {
  static const String base = 'assets/icons';
  static const String extension = 'svg';

  static String getPath(String name) {
    return '$base/$name.$extension';
  }

  static final String fire = getPath('fire');
  static final String heartMonitor = getPath('heart_monitor');
  static final String heartRate = getPath('heart_rate');
  static final String moon = getPath('moon');
  static final String settings = getPath('settings');
  static final String star = getPath('star');
  static final String steps = getPath('steps');
  static final String timer = getPath('timer');

  // Activities
  static final String cardio = getPath('cardio');
  static final String cycling = getPath('cycling');
  static final String dance = getPath('dance');
  static final String hiit = getPath('hiit');
  static final String hiking = getPath('hiking');
  static final String intervals = getPath('intervals');
  static final String pilates = getPath('pilates');
  static final String running = getPath('running');
  static final String strengthTraining = getPath('strength_training');
  static final String swimming = getPath('swimming');
  static final String walking = getPath('walking');
  static final String yoga = getPath('yoga');
}
