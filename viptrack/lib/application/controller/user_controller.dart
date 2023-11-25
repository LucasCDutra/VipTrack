import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/user.dart';
import 'package:viptrack/utils/mask.dart';
import 'package:viptrack/widgets/input_label.dart';

class UserController extends GetxController {
  final SharedPref sharedPref = SharedPref();
  final user = FirebaseAuth.instance.currentUser;
  UserApp currentUser = UserApp(auth: FirebaseAuth.instance);

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  String nomePreController = '';
  String emailPreController = '';
  String telefonePreController = '';

  setUserApp({String? nomeU, String? telefoneU, String? email}) {
    currentUser = UserApp(uid: user?.uid, email: user?.email, nome: nomeU, telefone: telefoneU, auth: currentUser.auth);
    currentUser.save();
  }

  getCurrentUserInfo() async {
    await currentUser.readCurrrent();
    sharedPref.setUserCurrent(currentUser);
    nomeController.text = currentUser.nome ?? '';
    emailController.text = currentUser.email ?? '';
    telefoneController.text = currentUser.telefone ?? '';
    update();
  }

  saveControllerText(TextEditingController controller, String type) {
    update();
  }

  saveUser() {
    setUserApp(email: emailController.text, telefoneU: telefoneController.text, nomeU: nomeController.text);
  }

  verifUserData(BuildContext context) async {
    await getCurrentUserInfo();
    print(currentUser.toJson());
    if ((currentUser.nome == null || currentUser.nome == '') ||
        (currentUser.telefone == null) ||
        currentUser.telefone == '') {
      print('entrou no show Custon dialod');
      // ignore: use_build_context_synchronously
      showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 30, 3, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 9),
                              height: 150,
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text(
                                  'Algumas informações do seu usuário ainda precisam ser preenchidas',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 34, 34, 34),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Varela',
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 9),
                              height: 350,
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Column(
                                  children: [
                                    InputLabel(
                                      label: 'Nome',
                                      hintText: 'Ex: José Silva',
                                      controller: nomeController,
                                      keyboardType: TextInputType.name,
                                      onEditingComplete: saveControllerText(nomeController, 'nome'),
                                    ),
                                    InputLabel(
                                      label: 'Email',
                                      hintText: 'Ex: jose@email.com',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      onEditingComplete: saveControllerText(emailController, 'email'),
                                    ),
                                    InputLabel(
                                      label: 'Celular',
                                      hintText: 'Ex: (99) 99999-9999',
                                      keyboardType: TextInputType.phone,
                                      controller: telefoneController,
                                      inputFormatter: [maskCelular],
                                      onEditingComplete: saveControllerText(telefoneController, 'celular'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Depois',
                                    style: TextStyle(color: Colors.grey.shade400),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    saveUser();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration:
                                        BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                                    child: const Center(
                                      child: Text(
                                        'Salvar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          Tween<Offset> tween;
          if (anim.status == AnimationStatus.reverse) {
            tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
          } else {
            tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
          }

          return SlideTransition(
            position: tween.animate(anim),
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          );
        },
      );
    }
  }
}
