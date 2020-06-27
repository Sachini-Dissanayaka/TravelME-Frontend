import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'HeadOne.dart';
import 'package:url_launcher/url_launcher.dart';
import 'first_screen.dart';
import 'home.dart';
import 'package:map_launcher/map_launcher.dart';

class Hotel extends StatefulWidget {
  List allHotels;
  Hotel(this.allHotels);
  @override
  _HotelState createState(){ 
    return _HotelState(this.allHotels);
  }
}

class _HotelState extends State<Hotel> {
  final String phone = 'tel:+2347012345678';
  List allHotels;
  _HotelState(this.allHotels);

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
        title: new Text('Hotels'),
        backgroundColor: Colors.green[900],
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: allHotels == null ? 0 : allHotels.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: Wrap(
                    children: <Widget>[
                      Image.network(allHotels[index]["img"]),
                      SizedBox(height: 40),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                              child: Text("${allHotels[index]["name"]}",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis),
                              onTap: () {
                                launch("${allHotels[index]["hotelUrl"]}");
                              }),
                          SizedBox(width: 30),
                          IconButton(
                            icon: Icon(
                              Icons.place,
                              color: Colors.red[900],
                            ),
                            onPressed: () async {
                              if (await MapLauncher.isMapAvailable(
                                  MapType.google)) {
                                await MapLauncher.launchMap(
                                  mapType: MapType.google,
                                  coords: Coords(allHotels[index]["lat"],
                                      allHotels[index]["lng"]),
                                  title: "${allHotels[index]["name"]}",
                                  description: "${allHotels[index]["address"]}",
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "${allHotels[index]["address"]}",
                        style: TextStyle(color: Colors.black87, fontSize: 17),
                      ),
                      SizedBox(height: 40),
                    ],
                  )),
            );
          } 
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
