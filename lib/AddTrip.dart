import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'sign_in.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Trip.dart';

Map data;
List userData;
List distance;
String city;

class CityFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'City can\'t be empty' : null;
  }
}
class DayFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'Number of days can\'t be empty' : null;
  }
}
class AddTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Myform());
  }
}

class Myform extends StatefulWidget {
  @override
  MyformState createState() {
    return MyformState();
  }
}

class MyformState extends State<Myform> {
  final myController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _typeAheadController1 = TextEditingController();
  String _selectedCity;
  String _days;

  Future _makePostRequest() async {
    http.Response response = await http.post(
      'https://noderestapp.azurewebsites.net/planTrip',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, String>{
        'place': _selectedCity,
        'days': _days,
      }),
    );
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      setState(() {
        userData = data["trip"];
        distance = data["distances"];
      });
      debugPrint(userData.toString());
    } else {
      throw Exception('Failed to create Trip.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Container(
          padding: const EdgeInsets.all(30.0),
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Hey " + name + " !",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    imageUrl,
                  ),
                  radius: 20,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            new Padding(padding: EdgeInsets.only(top: 30.0)),
            new Text(
              'Let\'s Plan Your Trip..',
              style: new TextStyle(
                  color: Colors.green[900],
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            new Padding(padding: EdgeInsets.only(top: 30.0)),
            new TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: this._typeAheadController,
                decoration: new InputDecoration(
                  labelText: "Enter City",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              suggestionsCallback: (pattern) {
                return CitiesService.getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                this._typeAheadController.text = suggestion;
              },
              
              validator: CityFieldValidator.validate,

              onSaved: (value) => this._selectedCity = value,
            ),
            SizedBox(height: 20),
            new TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: this._typeAheadController1,
                    decoration: new InputDecoration(
                      labelText: "Enter Number of Days",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    style: new TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ]),
                suggestionsCallback: (pattern) {
                  return DaysService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  this._typeAheadController1.text = suggestion;
                },
                
                validator: DayFieldValidator.validate,

                onSaved: (value) => this._days = value),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                if (this._formKey.currentState.validate()) {
                  this._formKey.currentState.save();
                  city= this._selectedCity;
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Trip to ${this._selectedCity} for ${this._days} days')));
                  _makePostRequest();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlanTrip()),
                  );
                }
              },
              color: Colors.green[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          ]))),
    );
  }
}

class CitiesService {
  static final List<String> cities = [
    'Polonnaruwa',
    'Anuradhapura',
    'Kandy',
    'Colombo',
    'Matara',
    'Galle',
    'Hambantota',
    'Puttalam',
    'Sigiriya',
    'Kurunegala',
    'Kalutara',
    'Jaffna',
    'Trincomalee',
    'Pinnawala',
    'Gampaha',
    'Nuwara Eliya',
    'Badulla',
    'Mannar'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class DaysService {
  static final List<String> days = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(days);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
