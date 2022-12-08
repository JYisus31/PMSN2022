import 'package:flutter/material.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/screens/edit_user_screen.dart';
import 'package:practica1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

import '../database/account_database_helper.dart';
import '../models/account_model.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AccountDatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = AccountDatabaseHelper();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
          future: _databaseHelper.getAllAccounts(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AccountModel>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Ocurrio un error en la petición'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                print('>>>HERE COMES DATA!!!');
                print(snapshot.data!.first);
                return _accountList(snapshot.data!);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  Widget _accountList(List<AccountModel> accountInformation) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(milliseconds: 500), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          AccountModel accountInfo = accountInformation[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    heightFactor: 1,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'user_tag',
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(
                            'https://image.artistshot.com/pd.23556459.158.445877.s3.1-front-customized-f5f5f5-none-x42.524y21.524-302.95218971626-250x250.jpg'),
                      ),
                    ),
                  ),
                  Text(
                    'Nombre:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Apellido paterno:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.lastName1!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Apellido materno:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.lastName2!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Número de teléfono:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.phoneNumber!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Git:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.git!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Avatar:',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.avatar!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 20,
                        color: Colors.blueGrey,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserScreen(account: accountInfo)));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: accountInformation.length,
      ),
    );
  }
}
