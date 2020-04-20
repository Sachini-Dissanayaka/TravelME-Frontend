import 'package:flutter/material.dart';
import 'hotel.dart';
import 'travel_agency.dart';
import 'HeadOne.dart';

class Trip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('TravelME'),
        backgroundColor: Colors.purple,
      ),
      persistentFooterButtons: <Widget>[
        new IconButton(
            icon: new Icon(Icons.home),
            color: Colors.purple,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavHome()),
              );
            }),
      ],
      drawer: new Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Text(
                    'TravelME Navigator',
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(children: [
                ListTile(
                  leading: Icon(
                    Icons.hotel,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'Hotels',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Hotel()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.business_center,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'Travel Agency',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TravelAgency()),
                    );
                  },
                ),
              ]),
            )
          ],
        ),
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
                'Planned Trip',
                style: new TextStyle(color: Colors.purple, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
