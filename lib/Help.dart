import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple[50], Colors.purple[100]],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              new Padding(padding: EdgeInsets.only(top: 50.0)),
              new Text(
                'Help Center',
                style: new TextStyle(color: Colors.purple, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
