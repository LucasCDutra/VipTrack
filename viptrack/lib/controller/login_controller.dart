import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signUserIn(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    String email = emailController.text;
    String pass = passwordController.text;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print("code => ${e.code}");

      if (e.code == 'user-not-found') {
        wrongMessage(context, "Email não encontrado");
      } else if (e.code == 'wrong-password') {
        wrongMessage(context, "Senha incorreta");
      } else if (e.code == 'invalid-email') {
        wrongMessage(context, "Email incorreto");
      }
    }
  }

  void wrongMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
