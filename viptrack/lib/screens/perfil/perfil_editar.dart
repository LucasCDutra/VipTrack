// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viptrack/application/controller/perfil_controller.dart';
import 'package:viptrack/application/controller/user_controller.dart';
import 'package:viptrack/utils/mask.dart';
import 'package:viptrack/widgets/input_label.dart';

class PerfilEditar extends StatefulWidget {
  final PerfilController perfilController;

  const PerfilEditar({super.key, required this.perfilController});

  @override
  State<PerfilEditar> createState() => _PerfilEditarState();
}

class _PerfilEditarState extends State<PerfilEditar> {
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: Colors.transparent,
        child: GetBuilder<UserController>(
            init: userController,
            builder: (_) {
              return Center(
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
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 9),
                              height: 350,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 245, 245, 245),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Column(
                                  children: [
                                    InputLabel(
                                      label: 'Nome',
                                      hintText: 'Ex: José Silva',
                                      controller: _.nomeController,
                                      keyboardType: TextInputType.name,
                                      onEditingComplete: _.saveControllerText(_.nomeController, 'nome'),
                                    ),
                                    InputLabel(
                                      label: 'Email',
                                      hintText: 'Ex: jose@email.com',
                                      controller: _.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      onEditingComplete: _.saveControllerText(_.emailController, 'email'),
                                    ),
                                    InputLabel(
                                      label: 'Celular',
                                      hintText: 'Ex: (99) 99999-9999',
                                      keyboardType: TextInputType.phone,
                                      controller: _.telefoneController,
                                      inputFormatter: [maskCelular],
                                      onEditingComplete: _.saveControllerText(_.telefoneController, 'celular'),
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
                                    'Cancelar',
                                    style: TextStyle(fontSize: 17, color: Colors.grey.shade400),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    await _.saveUser();
                                    await _.getCurrentUserInfo();
                                    await widget.perfilController.initializePagePerfil();
                                    widget.perfilController.update();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration:
                                        BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                                    child: const Center(
                                      child: Text(
                                        'Salvar',
                                        style: TextStyle(fontSize: 17, color: Colors.white),
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
              );
            }),
      ),
    );
  }
}
