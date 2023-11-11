import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  int currentIndex = 0;
  final pageController = PageController();

  void navigateForBottomBar(int index) {
    print('INDEX => $index');
    currentIndex = index;
    pageController.jumpToPage(index);
  }
}
