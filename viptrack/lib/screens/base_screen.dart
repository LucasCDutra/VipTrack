import 'package:flutter/material.dart';
import 'package:viptrack/application/controller/base_controller.dart';
import 'package:viptrack/application/controller/login_controller.dart';
import 'package:viptrack/application/controller/user_controller.dart';
import 'package:viptrack/screens/screen_caronas.dart';
import 'package:viptrack/screens/screen_offer_ride.dart';
import 'package:viptrack/screens/screen_perfil.dart';
import 'package:viptrack/screens/screen_search_car.dart';
import 'package:viptrack/widgets/bottom_bar_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = UserController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 150)).then((value) => userController.verifUserData(context));
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = LoginController();
    final BaseController baseController = BaseController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'VIPTrack',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: BottomBarCustom(
            controller: baseController,
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: baseController.pageController,
        children: const [
          ScreenSearchCar(),
          ScreenOffenRide(),
          ScreenCaronas(),
          ScreenPerfil(),
        ],
      ),
    );
  }
}
