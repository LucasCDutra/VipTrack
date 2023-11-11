import 'package:flutter/material.dart';

class ScreenMessage extends StatelessWidget {
  const ScreenMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.greenAccent,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
