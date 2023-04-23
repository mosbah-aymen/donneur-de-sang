import 'package:donneurs_de_sang/components/FormFieldCustom.dart';
import 'package:donneurs_de_sang/components/flat_buttton.dart';
import 'package:donneurs_de_sang/constants.dart';
import 'package:donneurs_de_sang/global_functions.dart';
// ignore: unused_import
import 'package:donneurs_de_sang/screens/signin/choose_type.dart';
import 'package:donneurs_de_sang/screens/signin/login_container.dart';
import 'package:donneurs_de_sang/screens/signin/signup_donneur.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home_screen.dart';

class LoginDonneur extends StatefulWidget {
  const LoginDonneur({Key? key}) : super(key: key);

  @override
  _LoginDonneurState createState() => _LoginDonneurState();
}

class _LoginDonneurState extends State<LoginDonneur> {
  TextEditingController emailController = TextEditingController(), passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Mobile wireframe-cuate.png',
                  height: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                FieldCustom(
                  title: 'Email',
                  icon: Icons.email,
                  child: TextFormField(
                    decoration: decoration('Email'),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FieldCustom(
                  title: 'Mot de passe',
                  icon: Icons.lock,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: decoration('mot de passe'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FlatButton(
                  text: "Login",
                  onTap: () async {
                    wait(context);
                    await login(emailController.text, passwordController.text).then((value) {
                      if (value.isEmpty) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: value, backgroundColor: primaryColor, gravity: ToastGravity.CENTER);
                      }
                    });
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ou bien'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupDonneur()));
                        },
                        child: const Text('creer un compte')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
