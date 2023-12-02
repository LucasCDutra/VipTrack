import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viptrack/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color? textColor;
  final Color? backgroudColor;

  const RoundedButton({
    Key? key,
    this.press,
    this.textColor = Colors.white,
    required this.text,
    this.backgroudColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroudColor ?? kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              letterSpacing: 2, color: textColor, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 17),
      ),
    );
  }
}
