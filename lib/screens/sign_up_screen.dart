import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica1/firebase/email_authentication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastName1Controller = TextEditingController();
  TextEditingController _lastName2Controller = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _gitController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  EmailAuthentication? _emailAuth;

  @override
  void initState() {
    super.initState();
    _emailAuth = EmailAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Create profile'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _emailTextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              _pwdTextfieldWidget(),
              SizedBox(
                height: 10,
              ),
              _SaveBtn(),
            ],
          ),
        ));
  }

  Widget _SaveBtn() {
    return ElevatedButton(
      onPressed: () {
        _emailAuth!
            .createUserWithEmailAndPassword(
                //email: '17031150@itcelaya.edu.mx', password: '12345678  ')
                email: _emailController.text,
                password: _pwdController.text)
            .then((value) {});
        //Navigator.pop(context);
      },
      child: Text('Guardar'),
    );
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

  Widget _pwdTextfieldWidget() {
    return TextField(
      controller: _pwdController,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: "PWD",
      ),
      onChanged: (value) {},
    );
  }
}
