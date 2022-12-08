import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica1/models/account_model.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import '../database/account_database_helper.dart';

//ListPopularScreen
class EditUserScreen extends StatefulWidget {
  AccountModel? account;
  EditUserScreen({Key? key, this.account}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late AccountDatabaseHelper _accountDatabaseHelper;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastName1Controller = TextEditingController();
  TextEditingController _lastName2Controller = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _gitController = TextEditingController();

  File? _image;
  String? _imagePath;

  Future saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    print(image.path);
    setState(() {
      this._imagePath = image.path;
    });

    return File(imagePath).copy(image.path);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() {
        this._image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Filed to pick image: $e');
    }
  }

  @override
  void initState() {
    _nameController.text = widget.account!.name!;
    _lastName1Controller.text = widget.account!.lastName1!;
    _lastName2Controller.text = widget.account!.lastName2!;
    _phoneNumberController.text = widget.account!.phoneNumber!;
    _emailController.text = widget.account!.email!;
    _gitController.text = widget.account!.git!;

    _accountDatabaseHelper = AccountDatabaseHelper();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: widget.account == null ? Text('Perfil') : Text('Edit profile'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _nameTextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              _lastName1TextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              _lastName2TextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              _phoneNumberTextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              _emailTextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              _gitTextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              Center(
                child: _image == null
                    ? Text('No se ha seleccionado imagen')
                    : Image.file(
                        _image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      child: Icon(Icons.save),
                      color: Colors.black,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // backgroundColor: Colors.black,
                      onPressed: () {
                        if (_imagePath == null) {
                          _imagePath = "route/profile.jpg";
                        }
                        AccountModel account = AccountModel(
                            id: 1,
                            name: _nameController.text,
                            lastName1: _lastName1Controller.text,
                            lastName2: _lastName2Controller.text,
                            phoneNumber: _phoneNumberController.text,
                            email: _emailController.text,
                            git: _gitController.text,
                            avatar: _imagePath);
                        _accountDatabaseHelper
                            .update(account.toMap())
                            .then((value) {
                          if (value > 0) {
                            setState(() {});
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'ERRORRRRR!!!!!!!! No se completó la solicitud')));
                          }
                        });
                      }),
                  MaterialButton(
                    child: Icon(Icons.camera),
                    color: Colors.black,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    // backgroundColor: Colors.black,
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                  ),
                  MaterialButton(
                    child: Icon(Icons.image),
                    color: Colors.black,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    // backgroundColor: Colors.black,
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _nameTextfieldWidget() {
    return TextField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Nombre del perfil",
      ),
      onChanged: (value) {},
    );
  }

  Widget _lastName1TextfieldWidget() {
    return TextField(
      controller: _lastName1Controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Apellido paterno",
      ),
      onChanged: (value) {},
    );
  }

  Widget _lastName2TextfieldWidget() {
    return TextField(
      controller: _lastName2Controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Apellido materno",
      ),
      onChanged: (value) {},
    );
  }

  Widget _phoneNumberTextfieldWidget() {
    return TextField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Número de teléfono",
      ),
      onChanged: (value) {},
    );
  }

  Widget _emailTextfieldWidget() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Correo electrónico",
      ),
      onChanged: (value) {},
    );
  }

  Widget _gitTextfieldWidget() {
    return TextField(
      controller: _gitController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "Usuario de GitHub",
      ),
      onChanged: (value) {},
    );
  }
}
