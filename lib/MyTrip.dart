import 'package:flutter/material.dart';
import 'HeadOne.dart';

class MyTrip extends StatelessWidget {
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
              new Padding(padding: EdgeInsets.only(top: 20.0)),
              new Text(
                'My Trips',
                style: new TextStyle(color: Colors.purple, fontSize: 30.0,fontWeight: FontWeight.bold),
              ),
              Container(
              padding: const EdgeInsets.only(top:32.0,bottom:32.0,right:16.0,left:16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   new Text('Kandy',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    new Text('3 Days',style: TextStyle(color:Colors.grey.shade600,fontSize: 15),),
                  SizedBox(height:20),
                  Image(image: AssetImage("assets/Kandy_Temple_Tooth.jpg")),
                ],
              )),
              
            ],
          ),
        ),
        
      ),
    );
  }
}