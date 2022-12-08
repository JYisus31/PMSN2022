// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:practica1/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
          backgroundColor: Color.fromARGB(112, 67, 126, 174),
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://i.ytimg.com/vi/VvIJioXyKaQ/maxresdefault.jpg'),
                        fit: BoxFit.cover),
                  ),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile-info');
                    },
                    child: const Hero(
                      tag: 'user_tag',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://image.artistshot.com/pd.23556459.158.445877.s3.1-front-customized-f5f5f5-none-x42.524y21.524-302.95218971626-250x250.jpg'),
                      ),
                    ),
                  ),
                  accountName: Text('JYius',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  accountEmail: Text('Rico.juarez.jesus.1.j@gmail.com',
                      style: TextStyle(color: Colors.black, fontSize: 18))),
              ListTile(
                leading: Image.asset('assets/nube.png'),
                trailing: Icon(Icons.chevron_right),
                title: Text('Practica 1'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile-info');
                },
              ),
              ListTile(
                leading: Image.asset('assets/nube.png'),
                trailing: Icon(Icons.chevron_right),
                title: Text('Base de datos'),
                onTap: () {
                  Navigator.pushNamed(context, '/task');
                },
              ),
              ListTile(
                leading: Image.asset('assets/nube.png'),
                trailing: Icon(Icons.chevron_right),
                title: Text('Places'),
                onTap: () {
                  Navigator.pushNamed(context, '/places');
                },
              ),
              ListTile(
                leading: Image.asset('assets/nube.png'),
                trailing: Icon(Icons.chevron_right),
                title: Text('API'),
                onTap: () {
                  Navigator.pushNamed(context, '/list');
                },
              ),
              ListTile(
                leading: Image.asset('assets/nube.png'),
                trailing: Icon(Icons.chevron_right),
                title: Text('Onboarding Screen'),
                onTap: () {
                  Navigator.pushNamed(context, '/onboarding');
                },
              ),
              ListTile(
                leading: Image.asset('assets/nube.png'),
                trailing: Icon(Icons.chevron_right),
                title: Text('About Us'),
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              ListTile(
                leading: Image.asset('assets/nube.png'),
                trailing: Icon(Icons.chevron_right),
                title: Text('cerrar sesión'),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  _prefs.setBool('login', true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                  //Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
              ),
            ],
          )),
      body: ThemeScreen(),
    );
  }
}
