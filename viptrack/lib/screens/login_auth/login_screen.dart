import 'package:flutter/material.dart';
import 'package:viptrack/components/components.dart';
import 'package:viptrack/components/under_part.dart';
import 'package:viptrack/utils/constants.dart';
import 'package:viptrack/controller/login_controller.dart';
import 'package:viptrack/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  final Function() onTap;
  const LoginScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = LoginController();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            //reverse: true,
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/images/login.png",
                ),
                const PageTitleBar(title: 'Entre com sua conta'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Column(
                            children: [
                              RoundedInputField(
                                hintText: "Email",
                                icon: Icons.email,
                                textController: loginController.emailController,
                              ),
                              RoundedInputField(
                                hintText: "Senha",
                                icon: Icons.lock,
                                isSecret: true,
                                textController: loginController.passwordController,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Esqueceu a senha?',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              RoundedButton(
                                  text: 'ENTRAR',
                                  press: () {
                                    loginController.signUserIn(context);
                                  }),
                              const SizedBox(height: 15),
                              dividerWithText(),
                              const SizedBox(height: 15),
                              iconButton(context),
                              const SizedBox(height: 25),
                              UnderPart(
                                title: "Não possui uma conta?",
                                navigatorText: "Registre aqui",
                                onTap: widget.onTap

                                // () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               const SignUpScreen()));
                                // }
                                ,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              )
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

dividerWithText() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Ou continue com",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
        ),
      ],
    ),
  );
}

iconButton(BuildContext context) {
  final LoginController loginController = LoginController();
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () => loginController.signInWithGoogle(),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 2,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/google.jpg"),
              backgroundColor: Colors.white,
              radius: 20,
            ),
          ),
        ),
      ),
    ],
  );
}
