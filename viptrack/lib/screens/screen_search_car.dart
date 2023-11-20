import 'package:flutter/material.dart';
import 'package:viptrack/application/controller/user_controller.dart';

class ScreenSearchCar extends StatelessWidget {
  const ScreenSearchCar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final UserController userController = UserController();

    //userController.verifUserData(context);
    return Container(
      color: Colors.purpleAccent,
      height: double.infinity,
      width: double.infinity,
      child: TextButton(
          onPressed: () => userController.verifUserData(context),
          child: Container(
            color: Colors.white,
            width: 200,
            height: 100,
            child: Text('teste'),
          )),
    );
  }
}
