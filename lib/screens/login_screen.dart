// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:practica1/screens/theme_screen.dart';
import 'package:practica1/settings/styles_settings.dart';

import '../firebase/email_authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailAuthentication _emailAuth = EmailAuthentication();

  bool isChecked = false;
  late SharedPreferences _prefs;
  late bool newuser;
  late String t;

  void initState() {
    super.initState();
    preferencias();
  }

  definirTema() async {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    _prefs = await SharedPreferences.getInstance();
    t = (_prefs.getString('tema') ?? 'dia');

    if (t == 'dia') {
      tema.setthemeData(temaDia());
    } else if (t == 'noche') {
      tema.setthemeData(temaNoche());
    } else if (t == 'calido') {
      tema.setthemeData(temaCalido());
    }
  }

  preferencias() async {
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool('showHome') ?? false;
    _prefs = await SharedPreferences.getInstance();
    newuser = (_prefs.getBool('login') ?? true);
    if (newuser == false && showHome == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else {
      if (newuser == false && showHome == false) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    definirTema();
    final txtUser = TextField(
      controller: txtConUser,
      decoration: InputDecoration(
          hintText: 'Introduce el usuario', label: Text('Usuario')),
      //onChanged: (value){},
    );
    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration:
          InputDecoration(hintText: 'contraseña', label: Text('Contraseña')),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background_image.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                'assets/logo_mario.png',
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 20,
                bottom: MediaQuery.of(context).size.width / 30,
              ),
              color: Color.fromARGB(44, 180, 139, 89),
              child: ListView(
                shrinkWrap: true,
                children: [
                  txtUser,
                  SizedBox(
                    height: 15,
                  ),
                  txtPwd,
                  SizedBox(
                    height: 15,
                  ),
                  CheckboxListTile(
                    value: isChecked,
                    title: const Text(
                      'Recordar datos',
                      style: TextStyle(
                          color: Color.fromARGB(255, 11, 101, 128),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                        _prefs.setBool('login', false);
                      });
                    },
                    secondary: const Icon(
                      Icons.remember_me,
                      color: Color.fromARGB(255, 11, 101, 128),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 30,
              child: GestureDetector(
                onTap: () async {
                  var ban = await _emailAuth.signInWithEmailAndPassword(
                      email: txtConUser.text, password: txtConPwd.text);
                  if (ban == true) {
                    if (_auth.currentUser!.emailVerified) {
                      Navigator.pushNamed(context, '/dash');
                    } else {
                      print('Usuario no válido');
                    }
                  } else {
                    print('Credenciales inválidas');
                  }
                },
                child: Image.asset(
                  'assets/block.png',
                  height: MediaQuery.of(context).size.width / 5,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 50,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 17),
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  //shrinkWrap: true,
                  children: [
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.facebook,
                      onPressed: () {
                        print('hola fb');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.github,
                      onPressed: () {
                        print('Hola Git');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () {
                        print('hola Google');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.width / 1.8,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Sing up',
                      style: TextStyle(color: Colors.blueGrey),
                    )))
          ],
        ),
      ),
    );
  }
}
