import 'package:get/get.dart';

import 'package:expance/app/modules/budget/bindings/budget_binding.dart';
import 'package:expance/app/modules/budget/views/budget_view.dart';
import 'package:expance/app/modules/chart/bindings/chart_binding.dart';
import 'package:expance/app/modules/chart/views/chart_view.dart';
import 'package:expance/app/modules/home/bindings/home_binding.dart';
import 'package:expance/app/modules/home/views/home_view.dart';
import 'package:expance/app/modules/setting/bindings/setting_binding.dart';
import 'package:expance/app/modules/setting/views/setting_view.dart';
import 'package:expance/app/modules/sign_in/bindings/sign_in_binding.dart';
import 'package:expance/app/modules/sign_in/views/sign_in_view.dart';
import 'package:expance/app/modules/spend/bindings/spend_binding.dart';
import 'package:expance/app/modules/spend/views/spend_view.dart';
import 'package:expance/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:expance/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:expance/app/modules/tabHome/bindings/tab_home_binding.dart';
import 'package:expance/app/modules/tabHome/views/tab_home_view.dart';
import 'package:expance/app/modules/tasks/bindings/tasks_binding.dart';
import 'package:expance/app/modules/tasks/views/tasks_view.dart';
import 'package:expance/app/modules/total/bindings/total_binding.dart';
import 'package:expance/app/modules/total/views/total_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.TASKS,
      page: () => TasksView(),
      binding: TasksBinding(),
    ),
    GetPage(
      name: _Paths.TOTAL,
      page: () => TotalView(),
      binding: TotalBinding(),
    ),
    GetPage(
      name: _Paths.BUDGET,
      page: () => BudgetView(),
      binding: BudgetBinding(),
    ),
    GetPage(
      name: _Paths.SPEND,
      page: () => SpendView(),
      binding: SpendBinding(),
    ),
    GetPage(
      name: _Paths.CHART,
      page: () => ChartView(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.TAB_HOME,
      page: () => TabHomeView(),
      binding: TabHomeBinding(),
    ),
  ];
}
