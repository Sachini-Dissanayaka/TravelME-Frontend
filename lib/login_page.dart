import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'first_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('TravelME'),
        backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 50.0)),
                      new Text('Welcome to TravelME',
                      style: new TextStyle(color: Colors.green[800] , fontSize: 35.0,fontWeight: FontWeight.bold),),
                      new Padding(padding: EdgeInsets.only(top: 50.0)),
              Image(image: AssetImage("assets/Logo.png"), height: 200, width: 200,),
              SizedBox(height: 50),
              _signInButton(),
              //This section for integration testing
              // SizedBox(height:30),
              // RaisedButton(
              //   key: Key('anonymous'),
              //   onPressed:(){
              //     name = "Sachini";
              //     email = "dmsachiniacc@gmail.com";
              //     imageUrl = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fin.pinterest.com%2Fheenashaikhonline11%2Fcute-baby-girl%2F&psig=AOvVaw36PmQOdH_Sw-OmbJcw1aAS&ust=1591893777142000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKChycrY9-kCFQAAAAAdAAAAABAD";
              //   Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => FirstScreen()),
              // );
              // })
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FirstScreen();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.green),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

