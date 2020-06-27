import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'HeadOne.dart';
import 'package:url_launcher/url_launcher.dart';
import 'first_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'home.dart';
import 'package:map_launcher/map_launcher.dart';
import 'Trip.dart';
import 'sign_in.dart';

class CityFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'City can\'t be empty' : null;
  }
}

class OwnTrip extends StatefulWidget {
  @override
  _OwnTripState createState() => _OwnTripState();
}

class _OwnTripState extends State<OwnTrip> {
  final TextEditingController _typeAheadController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map ownData;
  List ownUserData;
  List ownDistance;
  String _selectedCity;
  List nearPlaces;
  List _selectedPlaces = [];

  Future _makePostRequest() async {
    http.Response response = await http.post(
      'https://noderestapp.azurewebsites.net/customTripPlan',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(
          <String, dynamic>{"places": _selectedPlaces, "email": email}),
    );
    if (response.statusCode == 200) {
      ownData = json.decode(response.body);
      setState(() {
        ownUserData = ownData["trip"];
        ownDistance = ownData["distances"];
      });
      debugPrint(ownUserData.toString());
    } else {
      throw Exception('Failed to create Trip.');
    }
  }

  Future getNearPlaces() async {
    http.Response response = await http
        .get('https://noderestapp.azurewebsites.net/getPlace/$_selectedCity');
    nearPlaces = json.decode(response.body);
    setState(() {
      nearPlaces = nearPlaces;
    });
    debugPrint(nearPlaces.toString());
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _makePostRequest();
          await new Future.delayed(const Duration(seconds: 10));
          if (this._selectedPlaces.length > 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanTrip(
                      ownData, ownUserData, ownDistance, _selectedCity),
                ));
          } else {
            final snackBar = SnackBar(
              content: Text('Please select at least two places!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {},
              ),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green[800],
      ),
      body: Builder(
        builder: (context) => Container(
            color: Colors.green[50],
            child: SingleChildScrollView(
                child: Column(children: [
              Form(
                  key: _formKey,
                  child: Container(
                    width: 700,
                    height: 240,
                    alignment: Alignment.center,
                    child: new Stack(alignment: Alignment.center, children: <
                        Widget>[
                      Image.asset('assets/wall2.jpg',
                          width: 700, height: 240, fit: BoxFit.cover),
                      Container(
                          alignment: Alignment.center,
                          width: 260.0,
                          child: Column(children: [
                            new Padding(padding: EdgeInsets.only(top: 100.0)),
                            TypeAheadFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: this._typeAheadController,
                                decoration: new InputDecoration(
                                  hintText: "Enter City",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                    borderSide:
                                        new BorderSide(color: Colors.black),
                                  ),
                                ),
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
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
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (suggestion) {
                                this._typeAheadController.text = suggestion;
                              },
                              validator: CityFieldValidator.validate,
                              onSaved: (value) {
                                this._selectedCity = value;
                              },
                            ),
                            SizedBox(height: 20),
                            RaisedButton(
                              onPressed: () {
                                if (this._formKey.currentState.validate()) {
                                  this._formKey.currentState.save();
                                  this._selectedCity =
                                      this._typeAheadController.text;
                                  getNearPlaces();
                                }
                              },
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.search, color: Colors.white),
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                          ])),
                    ]),
                  )),
              SizedBox(height: 20),
              if (this._selectedCity != null)
                Text(
                  "Places Around You",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              if (this._selectedCity != null)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40.0),
                  height: 400,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearPlaces == null ? 0 : nearPlaces.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 180.0,
                          child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: Wrap(
                                children: <Widget>[
                                  Stack(
                                      alignment: Alignment.topLeft,
                                      children: <Widget>[
                                        Image.network(nearPlaces[index]["img"]),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(children: [
                                            new Padding(
                                                padding:
                                                    EdgeInsets.only(top: 1.0)),
                                            Ink(
                                              decoration: const ShapeDecoration(
                                                color: Colors.black,
                                                shape: CircleBorder(),
                                              ),
                                              child: IconButton(
                                                icon: Icon(Icons.star),
                                                color: Colors.red,
                                                highlightColor: Colors.black,
                                                onPressed: () {
                                                  _selectedPlaces.add(
                                                      "${nearPlaces[index]["placeId"]}");
                                                },
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ]),
                                  ListTile(
                                      title: Text(
                                        "${nearPlaces[index]["placeName"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "${nearPlaces[index]["bestReview"]}",
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                  IconButton(
                                    icon: Icon(Icons.place,
                                        color: Colors.red[900]),
                                    onPressed: () async {
                                      if (await MapLauncher.isMapAvailable(
                                          MapType.google)) {
                                        await MapLauncher.launchMap(
                                          mapType: MapType.google,
                                          coords: Coords(
                                              nearPlaces[index]["lat"],
                                              nearPlaces[index]["lng"]),
                                          title:
                                              "${nearPlaces[index]["placeName"]}",
                                          description:
                                              "${nearPlaces[index]["bestReview"]}",
                                        );
                                      }
                                    },
                                  )
                                ],
                              )),
                        );
                      }),
                ),
            ]))),
      ),
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
