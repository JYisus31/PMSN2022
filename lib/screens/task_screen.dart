import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Database_Helper? _database;

  bool ban = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = Database_Helper();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtFecha = TextEditingController();
    TextEditingController txtDesc = TextEditingController();
    int idTarea = 0;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final tarea = ModalRoute.of(context)!.settings.arguments as Map;
      ban = true;
      idTarea = tarea['idTarea'];
      txtFecha.text = tarea['fechaEnt'];
      txtDesc.text = tarea['dscTarea'];
    }
    final txtFechaEnt = TextField(
        controller: txtFecha,
        decoration: InputDecoration(border: OutlineInputBorder()));
    final txtDescTask = TextField(
        controller: txtDesc,
        maxLines: 8,
        decoration: InputDecoration(border: OutlineInputBorder()));
    final btnGuardar = ElevatedButton(
      onPressed: () {
        if (!ban) {
          _database!.insertar({
            'dscTarea': txtDesc.text,
            'fechaEnt': txtFecha.text,
          }, 'tblTareas').then((value) {
            final snackBar = SnackBar(content: Text("tarea registrada "));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          });
        } else {
          _database!.actualizar({
            'idTarea': idTarea,
            'dscTarea': txtDesc.text,
            'fechaEnt': txtFecha.text,
          }, 'tblTareas').then(
            (value) {
              final snackBar =
                  SnackBar(content: Text("Tarea Actualizada correctamente"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            },
          );
        }
      },
      child: Text('guardar'),
    );

    return Scaffold(
      appBar: AppBar(title: ban != true ? Text('Add task') : Text('Edit Task')),
      body: ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
          children: [
            txtFechaEnt,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: txtDescTask,
            ),
            btnGuardar
          ]),
    );
  }
}
