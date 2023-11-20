import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:viptrack/application/controller/base_controller.dart';

class BottomBarCustom extends StatelessWidget {
  final BaseController controller;

  const BottomBarCustom({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 8,
      backgroundColor: Colors.black,
      activeColor: Colors.white,
      color: Colors.white,
      tabBackgroundColor: Colors.grey.shade800,
      padding: const EdgeInsets.all(14),
      onTabChange: (index) => controller.navigateForBottomBar(index, context),
      tabs: const [
        GButton(icon: Icons.search_rounded, text: 'Procurar'),
        GButton(icon: Icons.drive_eta_rounded, text: 'Oferecer'),
        GButton(icon: Icons.message_outlined, text: 'Mensagens'),
        GButton(icon: Icons.person, text: 'Perfil'),
      ],
    );
  }
}
