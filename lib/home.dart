import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Home extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
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
              child: Column(children: [
            new Padding(padding: EdgeInsets.only(top: 50.0)),
            new Text(
              'Welcome to TravelME',
              style: new TextStyle(color: Colors.purple, fontSize: 25.0),
            ),
            new Padding(padding: EdgeInsets.only(top: 50.0)),
            new TextFormField(
              decoration: new InputDecoration(
                labelText: "Enter City",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "City cannot be empty";
                } else {
                  return null;
                }
              },
              style: new TextStyle(
                fontFamily: "Poppins",
                color: Colors.purpleAccent,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 40),
            new DateTimeField(
              decoration: new InputDecoration(
                labelText: "Start Date",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              style: new TextStyle(
                fontFamily: "Poppins",
                color: Colors.purpleAccent,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 40),
            new DateTimeField(
              decoration: new InputDecoration(
                labelText: "End Date",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              style: new TextStyle(
                fontFamily: "Poppins",
                color: Colors.purpleAccent,
                fontSize: 15.0,
              ),
            ),
          
          ]))),
    );
  }
}
