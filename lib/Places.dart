import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:getflutter/getflutter.dart';
import 'dart:async';
import 'HeadOne.dart';

class Place extends StatefulWidget {
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  Map data;
  List userData;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Most Popular Places'),
          backgroundColor: Colors.purple,
        ),
        body: ListView.builder(
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
                                                "${userData[index]["place"]}",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "\n${userData[index]["description"]}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                    color:
                                                        Colors.grey.shade600),
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
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
          itemCount: data == null ? 0 : userData.length,
          //   //body: displayImage(),
        ));
  }
}
