import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viptrack/application/controller/user_controller.dart';

class BaseController extends GetxController {
  int currentIndex = 0;
  final pageController = PageController();

  void navigateForBottomBar(int index, BuildContext context) {
    currentIndex = index;
    pageController.jumpToPage(index);
  }
}
