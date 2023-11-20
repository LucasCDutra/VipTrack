import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  void registerUser(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    String email = emailController.text;
    String pass = passwordController.text;
    String confirmpass = confirmPasswordController.text;

    try {
      print(pass != confirmpass);
      if (pass == confirmpass) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        wrongMessage(context, "Senhas não são iguais");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print("e.code = > ${e.code}");

      switch (e.code) {
        case 'email-already-in-use':
          wrongMessage(context, "Email já cadastrado");
          break;
        case 'weak-password':
          wrongMessage(context, "Senha muito fraca");
          break;
        default:
          wrongMessage(context, "Não foi possivel criar uma nova conta no momento, tente novamente mais tarde!");
      }
    }
  }

  void wrongMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
