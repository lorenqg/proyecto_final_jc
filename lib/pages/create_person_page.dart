import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jc_proyecto_final/models/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class CreatePersonPage extends StatefulWidget {
  const CreatePersonPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreatePersonPageState();
  }
}

class CreatePersonPageState extends State<CreatePersonPage> {
  var textEditingControllerName = TextEditingController();
  var textEditingControllerLastname = TextEditingController();
  var textEditingControllerDirection = TextEditingController();
  var textEditingControllerBirthdate = TextEditingController();
  var textEditingControllerSalary = TextEditingController();
  var textEditingControllerDate = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear persona'),
      ),
      body: Container(
        color: Colors.blueGrey,
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Center(
                child:Text("Nuevo Empleado",
                  style: TextStyle(color: Colors.black,
                      fontSize: 34.0),),
              ),
              const Text(' '),
              TextField(
                controller: textEditingControllerName,
                decoration: const InputDecoration(
                  hintText: 'Digite su Nombre',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius:
                  BorderRadius.horizontal
                    (left: Radius.circular(30), right: Radius.circular(30))),
                  filled: true,
                  fillColor: Colors.black45,
                ),
              ),
              const SizedBox(
                  height: 30.0
              ),
              TextField(
                controller:textEditingControllerLastname,
                decoration: const InputDecoration(
                  hintText: 'Digite su Apellido',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius:
                  BorderRadius.horizontal
                    (left: Radius.circular(30), right: Radius.circular(30))),
                  filled: true,
                  fillColor: Colors.black45,
                ),
              ),
              const SizedBox(
                  height: 30.0
              ),
              TextField(
                controller: textEditingControllerDirection,
                decoration: const InputDecoration(
                  hintText: 'Digite su Direccion',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius:
                  BorderRadius.horizontal
                    (left: Radius.circular(30), right: Radius.circular(30))),
                  filled: true,
                  fillColor: Colors.black45,
                ),
              ),
              const SizedBox(
                  height: 30.0
              ),
              TextField(
                controller:textEditingControllerBirthdate,
                decoration: const InputDecoration(
                  hintText: 'Digite su Fecha de Nacimiento  DD/MM/AA',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius:
                  BorderRadius.horizontal
                    (left: Radius.circular(30), right: Radius.circular(30))),
                  filled: true,
                  fillColor: Colors.black45,
                ),
              ),
              const SizedBox(
                  height: 30.0
              ),
              TextField(
                controller: textEditingControllerSalary,
                decoration: const InputDecoration(
                  hintText: 'Digite su Salario',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius:
                  BorderRadius.horizontal
                    (left: Radius.circular(30), right: Radius.circular(30))),
                  filled: true,
                  fillColor: Colors.black45,
                ),
              ),
              const SizedBox(
                  height: 30.0
              ),
              TextField(
                controller: textEditingControllerDate,
                decoration: const InputDecoration(
                  hintText: 'Digite su fecha de ingreso  DD/MM/AA',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderRadius:
                  BorderRadius.horizontal
                    (left: Radius.circular(30), right: Radius.circular(30))),
                  filled: true,
                  fillColor: Colors.black45,
                ),
              ),
              const SizedBox(
                  height: 30.0
              ),

              ElevatedButton(
                  onPressed: () {
                    callServiceCreatePerson(textEditingControllerName.text,
                        textEditingControllerLastname.text,
                        textEditingControllerDirection.text,
                        textEditingControllerBirthdate.text,
                        textEditingControllerSalary.text,
                        textEditingControllerDate.text);
                  },
                  child: const Text('Crear persona'))
            ],
          ),
        ),
      ),

    );
  }

  void callServiceCreatePerson(String name, String lasname, String direcion, String birthdate, String salary, String date) async {
    var person = Person(name: name, lastName: lasname, direction: direcion, birthdate: birthdate, salary: salary, date: date);

    var url = Uri.parse('https://617d6e191eadc50017136529.mockapi.io/Person');
    var personBody = jsonEncode(person);

    Response response = await http.post(
      url,
      body: personBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      Navigator.pop(context, true);
    } else {
      print('Hubo un error');
    }
  }
}
