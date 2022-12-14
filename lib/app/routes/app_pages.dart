import 'package:get/get.dart';

import 'package:mentomindtask/app/modules/first_screen/bindings/first_screen_binding.dart';
import 'package:mentomindtask/app/modules/first_screen/views/first_screen_view.dart';
import 'package:mentomindtask/app/modules/home/bindings/home_binding.dart';
import 'package:mentomindtask/app/modules/home/views/home_view.dart';
import 'package:mentomindtask/app/modules/question_screen/bindings/question_screen_binding.dart';
import 'package:mentomindtask/app/modules/question_screen/views/question_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.QUESTION_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FIRST_SCREEN,
      page: () => FirstScreenView(),
      binding: FirstScreenBinding(),
    ),
    GetPage(
      name: _Paths.QUESTION_SCREEN,
      page: () => QuestionScreenView(),
      binding: QuestionScreenBinding(),
    ),
  ];
}
