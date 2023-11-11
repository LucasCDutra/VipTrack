import 'package:flutter/material.dart';
import 'package:viptrack/components/components.dart';
import 'package:viptrack/components/under_part.dart';
import 'package:viptrack/controller/register_controller.dart';
import 'package:viptrack/screens/screens.dart';
import 'package:viptrack/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onTap;
  const SignUpScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = RegisterController();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/images/register.png",
                ),
                const PageTitleBar(title: 'Criar nova conta'),
                Padding(
                  padding: const EdgeInsets.only(top: 228),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Form(
                          child: Column(
                            children: [
                              RoundedInputField(
                                  hintText: "Email",
                                  icon: Icons.email,
                                  textController: registerController.emailController),
                              RoundedInputField(
                                  hintText: "Nome",
                                  icon: Icons.person,
                                  textController: registerController.usernameController),
                              RoundedInputField(
                                hintText: "Senha",
                                icon: Icons.lock,
                                isSecret: true,
                                textController: registerController.passwordController,
                              ),
                              RoundedInputField(
                                hintText: "Confirmar senha",
                                icon: Icons.lock,
                                isSecret: true,
                                textController: registerController.confirmPasswordController,
                              ),
                              RoundedButton(
                                  text: 'CRIAR',
                                  press: () {
                                    print("press Criar");
                                    registerController.registerUser(context);
                                  }),
                              const SizedBox(
                                height: 17,
                              ),
                              dividerWithText(),
                              const SizedBox(
                                height: 10,
                              ),
                              iconButton(context),
                              const SizedBox(
                                height: 13,
                              ),
                              UnderPart(
                                title: "Já possui uma conta?",
                                navigatorText: "Entrar agora",
                                onTap: widget.onTap,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
