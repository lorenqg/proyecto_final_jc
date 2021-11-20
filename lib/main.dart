import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jc_proyecto_final/pages/create_person_page.dart';
import 'package:jc_proyecto_final/models/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );

  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> listPersons = [];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto final J.C'),
        actions: [
          GestureDetector(
            onTap: () => callServiceGetListPersons(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.people),
            ),
          ),


        ],

      ),
      body: Center(
        child: PageView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.orange,
                ),
                const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(
                        "https://isteam.wsimg.com/ip/47fd6c14-f49d-422d-b828-b48b2051662f/J%C3%B3venes%20creaTIvos%20(2)-0001.png/:/cr=t:0%25,l:0%25,w:100%25,h:100%25/rs=w:400,cg:true"),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("BIENVENIDO",
                        style: TextStyle(fontSize: 30.0,
                            color: Colors.black,
                            fontFamily: 'RobotoMono'),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Icon(Icons.arrow_forward,
                        size: 70.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: listPersons.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0),
                  color: Colors.orange,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.account_circle_outlined,
                          color: Colors.black,
                          size: 45.0,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: (){
                            deletePerson('${listPersons[index].id}');
                          },
                        ),
                        title: Text(
                          '${listPersons[index].name!} ${listPersons[index]
                              .lastName!}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text('${listPersons[index].id!} ',
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.home,
                            color: Colors.blueAccent,
                            size: 37.0,),
                          Text('${listPersons[index].direction!} ',
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.calendar_today,
                            color: Colors.deepPurple,
                            size: 37.0,),
                          Text('${listPersons[index].birthdate!} ',
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.paid,
                            color: Colors.green,
                            size: 37.0,),
                          Text('${listPersons[index].salary!} ',
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.calendar_view_month,
                            color: Colors.purple,
                            size: 30.0,),
                          Text('${listPersons[index].date!} ',
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),


          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () => callCreatePersonPage(),
        child: const Icon(Icons.add),
      ),
    );
  }

  callCreatePersonPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreatePersonPage()))
        .then((value) {
      if (value) {
        callServiceGetListPersons();
      }
    });
  }

  callServiceGetListPersons() async {
    var url = Uri.parse('https://619837aa164fa60017c22fc0.mockapi.io/Person');
    Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      listPersons = (jsonDecode(response.body) as List).map((personJson) {
        return Person.fromJson(personJson);
      }).toList();

      setState(() {});
    } else {
      print('Hubo un error');
    }
  }

  deletePerson(id) async {
    var url =
    Uri.parse('https://617d6e191eadc50017136529.mockapi.io/Person/$id');
    Response response = await http.delete(url);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      callServiceGetListPersons();
      setState(() {});
    } else {
      print('Hubo un error al Eliminar');
    }
  }
}