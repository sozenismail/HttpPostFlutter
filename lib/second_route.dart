import 'package:flutter/material.dart';
import 'package:flutter_httppost/user_model.dart';

class SecondRoute extends StatelessWidget {
  final String name;
  final String job;

  const SecondRoute({this.name, this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              name,
              style: TextStyle(color: Colors.indigo, fontSize: 20),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              job,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
