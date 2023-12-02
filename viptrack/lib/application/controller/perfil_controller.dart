import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/user.dart';
import 'package:viptrack/utils/mask.dart';
import 'package:viptrack/widgets/input_label.dart';

class PerfilController extends GetxController {
  final SharedPref sharedPref = SharedPref();
  final user = FirebaseAuth.instance.currentUser;
  UserApp currentUser = UserApp(auth: FirebaseAuth.instance);

  initializePagePerfil() async {
    currentUser = sharedPref.getUserCurrent();
  }
}
