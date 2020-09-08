import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'second_route.dart';
import 'user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<UserModel> createUser(String name, String jobTitle) async {

  final String apiUrl = "https://reqres.in/api/users";

  final response =
  await http.post(apiUrl, body: {"name": name, "job": jobTitle});

  if (response.statusCode == 201) {
    final String responseString = response.body;

    print(response.body);

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  UserModel _user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "Adınız"),
              controller: nameController,
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Mesleğiniz"),
              controller: jobController,
            ),
            SizedBox(
              height: 32,
            ),
            _user == null || _user.name == "" || _user.job == ""
                ? Container()
                : Text(
                "Kullanıcı adı : ${_user.name}, ${_user.id} oluşturuldu. Zaman : ${_user.createdAt.toIso8601String()}")
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String name = nameController.text;
          final String jobTitle = jobController.text;

          final UserModel user = await createUser(name, jobTitle);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute(name:user.name, job:user.job )),
          );

          setState(() {
            _user = user;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
