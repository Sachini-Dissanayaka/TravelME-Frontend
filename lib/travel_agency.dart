import 'package:flutter/material.dart';

class TravelAgency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('TravelME'),
        backgroundColor: Colors.purple,
      ),
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
                'Find A Cab',
                style: new TextStyle(color: Colors.purple, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}