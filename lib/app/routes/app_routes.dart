part of 'app_pages.dart';

abstract class Routes {
  static const HOME = _Paths.HOME;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const TASKS = _Paths.TASKS;
  static const TOTAL = _Paths.TOTAL;
  static const BUDGET = _Paths.BUDGET;
  static const SPEND = _Paths.SPEND;
  static const CHART = _Paths.CHART;
  static const SETTING = _Paths.SETTING;
  static const TAB_HOME = _Paths.TAB_HOME;
}

abstract class _Paths {
  static const HOME = '/home';
  static const SPLASH_SCREEN = '/splash-screen';
  static const SIGN_IN = '/sign-in';
  static const TASKS = '/tasks';
  static const TOTAL = '/total';
  static const BUDGET = '/budget';
  static const SPEND = '/spend';
  static const CHART = '/chart';
  static const SETTING = '/setting';
  static const TAB_HOME = '/tab-home';
}
