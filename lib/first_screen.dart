import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_in.dart';
import 'HeadOne.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('TravelME'),
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavHome()),
          );
        },
        label: Text('Home'),
        icon: Icon(Icons.home),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple[50], Colors.purple[100]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                'My Profile',
                style: new TextStyle(color: Colors.purple, fontSize: 25.0),
              ),
              SizedBox(height: 40),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                color: Colors.purple[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(height: 40),
              // RaisedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Home()),
              //     );
              //   },
              //   color: Colors.deepPurple,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       'Home',
              //       style: TextStyle(fontSize: 25, color: Colors.white),
              //     ),
              //   ),
              //   elevation: 5,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(40)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
