import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unicorndial/unicorndial.dart';
import 'hotel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'HeadOne.dart';
import 'package:url_launcher/url_launcher.dart';
import 'first_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'AddReview.dart';
import 'sign_in.dart';
import 'Help.dart';

Map myTripsData;
List myTrips;

class CityFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'City can\'t be empty' : null;
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _typeAheadController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedCity;
  Map data;
  List userData;
  Map nearPlacesData;
  List nearPlaces;
  List allHotels;
 
  Future getMyTrips() async {
    http.Response response =
        await http.get('https://noderestapp.azurewebsites.net/myTrips/$email');
    myTripsData = json.decode(response.body);
    setState(() {
      myTrips = myTripsData["trips"];
    });
    debugPrint(myTrips.toString());
  }


  Future getHotels() async {
    http.Response response = await http.get(
        'https://noderestapp.azurewebsites.net/searchHotel/$_selectedCity');
    allHotels = json.decode(response.body);
    setState(() {
      allHotels = allHotels;
    });
    debugPrint(allHotels.toString());
  }

  Future getNearPlaces() async {
    http.Response response = await http.get(
        'https://noderestapp.azurewebsites.net/crawlNearestPlaces/$_selectedCity');
    nearPlacesData = json.decode(response.body);
    setState(() {
      nearPlaces = nearPlacesData["places"];
    });
    debugPrint(nearPlaces.toString());
  }

  Future getData() async {
    http.Response response =
        await http.get('https://noderestapp.azurewebsites.net/bestPlaces');
    data = json.decode(response.body);
    setState(() {
      userData = data["bestPlaces"];
    });
    debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
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
    var childButtons = List<UnicornButton>();
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Write Review",
        labelBackgroundColor: Colors.black,
        labelColor: Colors.white,
        currentButton: FloatingActionButton(
          heroTag: "review",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.create),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddReview()),
            );
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Create a Trip",
        labelBackgroundColor: Colors.black,
        labelColor: Colors.white,
        currentButton: FloatingActionButton(
          heroTag: "trip",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.favorite_border),
          onPressed: () {
            getMyTrips();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavTrip()),
            );
          },
        )));
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
            color: Colors.white,
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
                      Image.asset('assets/wall1.jpg',
                          width: 700, height: 240, fit: BoxFit.cover),
                      Container(
                          alignment: Alignment.center,
                          width: 260.0,
                          child: Column(children: [
                            new Padding(padding: EdgeInsets.only(top: 100.0)),
                            TypeAheadFormField(
                              key: Key("searchCity"),
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
                              key: Key("search"),
                              onPressed: () {
                                if (this._formKey.currentState.validate()) {
                                  this._formKey.currentState.save();
                                  this._selectedCity =
                                      this._typeAheadController.text;
                                  getHotels();
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
              Table(border: TableBorder.all(color: Colors.black54), children: [
                TableRow(children: [
                  new FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      if (this._selectedCity != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Hotel(allHotels)),
                        );
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Please enter a city!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.hotel),
                        SizedBox(height: 10),
                        Text("Hotels",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))
                      ],
                    ),
                  ),
                  new FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Help()),
                        );
                    },
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.help),
                        SizedBox(height: 10),
                        Text("Help",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))
                      ],
                    ),
                  ),
                ]),
              ]),
              SizedBox(height: 20),

              if (this._selectedCity != null)
                Text(
                  "Near Places",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              if (this._selectedCity != null)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 260,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearPlacesData == null ? 0 : nearPlaces.length,
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
                                  Image.network(nearPlaces[index]["img"]),
                                  ListTile(
                                      title: Text(
                                        "${nearPlaces[index]["place_name"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "${nearPlaces[index]["no_of_reviews"]}",
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                ],
                              )),
                        );
                      }),
                ),

              Text(
                "Most Popular Places",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 260,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data == null ? 0 : userData.length,
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
                                Image.network(userData[index]["img"]),
                                ListTile(
                                    title: Text(
                                      "${userData[index]["place"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "${userData[index]["description"]}",
                                      style: TextStyle(color: Colors.black54),
                                    )),
                              ],
                            )),
                      );
                    }),
              ),
            ]))),
      ),
      floatingActionButton: UnicornDialer(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
        parentButtonBackground: Colors.green[900],
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: childButtons,
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
                    key: Key("directTrip"),
                    onTap: () {
                      getMyTrips();
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
    'Galle',
    'Matara',
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
