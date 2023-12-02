import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viptrack/application/controller/perfil_controller.dart';
import 'package:viptrack/application/controller/user_controller.dart';
import 'package:viptrack/screens/perfil/perfil_editar.dart';
import 'package:viptrack/widgets/editar_perfil_button.dart';
import 'package:viptrack/widgets/widgets.dart';

class ScreenPerfil extends StatefulWidget {
  const ScreenPerfil({super.key});

  @override
  State<ScreenPerfil> createState() => _ScreenPerfilState();
}

class _ScreenPerfilState extends State<ScreenPerfil> {
  final PerfilController perfilController = Get.put(PerfilController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    perfilController.initializePagePerfil();
    return GetBuilder<PerfilController>(
        init: perfilController,
        builder: (_) {
          return Scaffold(
            body: SafeArea(
              minimum: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.only(bottom: 40),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person_pin_rounded,
                                    size: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      '${_.currentUser.nome}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(255, 153, 153, 153)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.mail,
                                    size: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      '${_.currentUser.email}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(255, 153, 153, 153)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone_android_outlined,
                                    size: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      '${_.currentUser.telefone}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(255, 153, 153, 153)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: EditarPerfilButton(
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (__) => PerfilEditar(
                      perfilController: _,
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
