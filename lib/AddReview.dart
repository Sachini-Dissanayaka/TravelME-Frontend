import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'sign_in.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'first_screen.dart';
import 'HeadOne.dart';

Map data;
List userData;

class CityReviewFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'City can\'t be empty' : null;
  }
}
class NameFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'Name can\'t be empty' : null;
  }
}
class ReviewFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'Review can\'t be empty' : null;
  }
}

class AddReview extends StatelessWidget {
  final String phone = 'tel:+2347012345678';

  _callPhone() async {
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }

  void _launchMapsUrl() async {
    final url = 'https://maps.google.lk/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Add Reviews'),
          backgroundColor: Colors.green[900],
        ),
        body: Myform(),
        bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 60,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.home, color: Colors.black),
                        Text(
                          "Home",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirstScreen()),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.black),
                        Text(
                          "Me",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavTrip()),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite_border, color: Colors.black),
                        Text(
                          "Trips",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: _callPhone,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.phone, color: Colors.black),
                        Text(
                          "Call",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: _launchMapsUrl,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.map, color: Colors.black),
                        Text(
                          "Map",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
        );
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
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _city;
  String _review;
  String _name;
  String _status;
  Map _response;

  Future _makePostRequest() async {
    http.Response response = await http.post(
      'https://noderestapp.azurewebsites.net/addReview',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, String>{
        'name': _name,
        'review': _review,
        'place': _city,
      }),
    );
    if (response.statusCode == 200) {
      _response = json.decode(response.body);
      setState(() {
        _status = _response["STATUS"];
      });
      debugPrint(_status.toString());
    } else {
      throw Exception('Failed to Add Review.');
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
              'Add Your Reviews..',
              style: new TextStyle(
                  color: Colors.green[900],
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            new Padding(padding: EdgeInsets.only(top: 30.0)),
            new TextFormField(
              controller: this._controller1,
              decoration: new InputDecoration(
                labelText: "Enter Your Name",
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
              validator: NameFieldValidator.validate,
              onSaved: (value) => this._name = value,
            ),
            SizedBox(height: 20),
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
              validator: CityReviewFieldValidator.validate,
              onSaved: (value) => this._city = value,
            ),
            SizedBox(height: 20),
            new TextFormField(
              controller: this._controller2,
              decoration: new InputDecoration(
                labelText: "Write Your Review",
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
              validator: ReviewFieldValidator.validate,
              onSaved: (value) => this._review = value,
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                if (this._formKey.currentState.validate()) {
                  this._formKey.currentState.save();
                   _makePostRequest();
                   if(_status=="OK"){
                     Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Your review is added successfully')));
                   }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => PlanTrip()),
                  // );
                }
              },
              color: Colors.green[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Submit',
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
