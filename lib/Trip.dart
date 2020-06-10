import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:unicorndial/unicorndial.dart';
import 'NearHotel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'first_screen.dart';
import 'home.dart';
import 'HeadOne.dart';
import 'hotel.dart';

class PlanTrip extends StatefulWidget {
  Map data;
  List userData;
  List distance;
  String _selectedCity;
  PlanTrip(this.data, this.userData, this.distance, this._selectedCity);
  @override
  _PlanTripState createState() {
    return _PlanTripState(
        this.data, this.userData, this.distance, this._selectedCity);
  }
}

class _PlanTripState extends State<PlanTrip> {
  String _place;
  String _lat;
  String _lng;
  List hotels;
  Map data;
  List userData;
  List distance;
  List allHotels;
  String _selectedCity;
  _PlanTripState(this.data, this.userData, this.distance, this._selectedCity);
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future getAllHotels() async {
    http.Response response = await http.get(
        'https://noderestapp.azurewebsites.net/searchHotel/$_selectedCity');
    allHotels = json.decode(response.body);
    setState(() {
      allHotels = allHotels;
    });
    debugPrint(allHotels.toString());
  }

  Future _makeHotelRequest() async {
    http.Response response = await http.post(
      'https://noderestapp.azurewebsites.net/nearestHotels',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(
          <String, String>{'place': _place, 'lat': _lat, 'lng': _lng}),
    );
    if (response.statusCode == 200) {
      hotels = json.decode(response.body);
      setState(() {
        hotels = hotels;
      });
      debugPrint(hotels.toString());
    } else {
      throw Exception('Failed to create Trip.');
    }
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

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      data = this.data;
      userData = this.userData;
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Find Hotels",
        labelBackgroundColor: Colors.black,
        labelColor: Colors.white,
        currentButton: FloatingActionButton(
          heroTag: "hotel",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.hotel),
          onPressed: () async{
            getAllHotels();
            await new Future.delayed(const Duration(seconds: 10));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Hotel(allHotels)),
            );
          },
        )));
    return Scaffold(
      appBar: new AppBar(
        title: new Text('TravelMe'),
        backgroundColor: Colors.green[900],
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0,
                                  bottom: 32.0,
                                  right: 16.0,
                                  left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      GFAvatar(
                                        size: 100.0,
                                        backgroundImage: NetworkImage(
                                            userData[index]["img"]),
                                        shape: GFAvatarShape.standard,
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${userData[index]["placeName"]}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "\nStart Time  ${userData[index]["startTimeH"]}:${userData[index]["startTimeM"]}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color:
                                                        Colors.grey.shade800),
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "End Time  ${userData[index]["endTimeH"]}:${userData[index]["endTimeM"]}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color:
                                                        Colors.grey.shade800),
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Day ${userData[index]["day"]}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color:
                                                        Colors.grey.shade800),
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.place,
                                                    color: Colors.red[900]),
                                                onPressed: () async {
                                                  if (await MapLauncher
                                                      .isMapAvailable(
                                                          MapType.google)) {
                                                    await MapLauncher.launchMap(
                                                      mapType: MapType.google,
                                                      coords: Coords(
                                                          userData[index]
                                                              ["lat"],
                                                          userData[index]
                                                              ["lng"]),
                                                      title:
                                                          "${userData[index]["placeName"]}",
                                                      description:
                                                          "${userData[index]["bestReview"]}",
                                                    );
                                                  }
                                                },
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  if (index < userData.length - 1 &&
                                      userData[index]["day"] !=
                                          userData[index + 1]["day"])
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.hotel),
                                        SizedBox(width: 20),
                                        GestureDetector(
                                            child: Text("Find a Hotel",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue[700],
                                                    fontSize: 17)),
                                            onTap: () async{
                                              _place =
                                                  "${userData[index]["placeName"]}";
                                              _lat =
                                                  "${userData[index]["lat"]}";
                                              _lng =
                                                  "${userData[index]["lng"]}";
                                              _makeHotelRequest();
                                              await new Future.delayed(const Duration(seconds: 10));
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NearHotel(hotels)),
                                              );
                                            })
                                      ],
                                    ),
                                  SizedBox(height: 10),
                                  if (index < userData.length - 1)
                                    Row(children: <Widget>[
                                      Icon(Icons.directions_car),
                                      SizedBox(width: 20),
                                      Text(
                                          "distance: ${distance[index]["distance"]}km\nTime: ${distance[index]["time"]}min",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black)),
                                    ]),
                                ],
                              )),
                        ],
                      ))
                ],
              ),
            );
          },
          itemCount: data == null ? 0 : userData.length,
          //   //body: displayImage(),
        ),
        onRefresh: refreshList,
      ),
      floatingActionButton: UnicornDialer(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
        parentButtonBackground: Colors.green[900],
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.search),
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
