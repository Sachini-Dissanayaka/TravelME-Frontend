import 'package:flutter/material.dart';

class Place extends StatelessWidget {
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
                  'Popular Places',
                  style: new TextStyle(color: Colors.purple, fontSize: 25.0),
                ),
                SizedBox(height: 40),
                new Card(
                child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Column(
                    children: <Widget>[
                      Image(image: AssetImage("assets/Kandy_Temple_Tooth.jpg")),
                      SizedBox(height: 20),
                      new Text("Sri Dalada Maligawa or the Temple of the Sacred Tooth Relic is a Buddhist temple in the city of Kandy, Sri Lanka. It is located in the royal palace complex of the former Kingdom of Kandy, which houses the relic of the tooth of the Buddha."),
                    ],
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
    );
  }
}
