import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'HeadOne.dart';
import 'package:url_launcher/url_launcher.dart';
import 'first_screen.dart';
import 'home.dart';
import 'package:map_launcher/map_launcher.dart';

class NearHotel extends StatefulWidget {
  List hotels;
  NearHotel(this.hotels);
  @override
  _NearHotelState createState() {
    return _NearHotelState(this.hotels);
  }
}

class _NearHotelState extends State<NearHotel> {
  final String phone = 'tel:+2347012345678';
  List hotels;
  _NearHotelState(this.hotels);

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
        title: new Text('Hotels Around You'),
        backgroundColor: Colors.green[900],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.green[50],
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
                                      backgroundImage:
                                          NetworkImage(hotels[index]["img"]),
                                      shape: GFAvatarShape.standard,
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                                child: Text(
                                                    "${hotels[index]["name"]}",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: Colors.black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onTap: () {
                                                  launch(
                                                      "${hotels[index]["hotelUrl"]}");
                                                }),
                                            Text(
                                              "\n${hotels[index]["address"]}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey.shade600),
                                              maxLines: 10,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.place,
                                                color: Colors.red[900],
                                              ),
                                              onPressed: () async {
                                                if (await MapLauncher
                                                    .isMapAvailable(
                                                        MapType.google)) {
                                                  await MapLauncher.launchMap(
                                                    mapType: MapType.google,
                                                    coords: Coords(
                                                        hotels[index]["lat"],
                                                        hotels[index]["lng"]),
                                                    title:
                                                        "${hotels[index]["name"]}",
                                                    description:
                                                        "${hotels[index]["address"]}",
                                                  );
                                                }
                                              },
                                            ),
                                          ]),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ))
              ],
            ),
          );
        },
        itemCount: hotels == null ? 0 : hotels.length,
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
