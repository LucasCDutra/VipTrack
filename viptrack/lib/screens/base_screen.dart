import 'package:flutter/material.dart';
import 'package:viptrack/components/bottom_bar_custom.dart';
import 'package:viptrack/controller/base_controller.dart';
import 'package:viptrack/controller/login_controller.dart';
import 'package:viptrack/screens/screen_messages.dart';
import 'package:viptrack/screens/screen_offer_ride.dart';
import 'package:viptrack/screens/screen_perfil.dart';
import 'package:viptrack/screens/screen_search_car.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        // actions: [
        //   IconButton(
        //     onPressed: () => loginController.logoutUser(),
        //     icon: const Icon(Icons.logout_outlined),
        //   ),
        // ],
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
          ScreenMessage(),
          ScreenPerfil(),
        ],
      ),
    );
  }
}
