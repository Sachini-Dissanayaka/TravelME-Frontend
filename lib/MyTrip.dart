import 'package:flutter/material.dart';
import 'home.dart';

class MyTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  children: [
                                    Icon(Icons.place,
                                        color: Colors.red[900], size: 30),
                                    SizedBox(width: 30),
                                    Text(
                                      "${myTrips[index]["topic"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ))
              ],
            ),
          );
        },
        itemCount: myTripsData == null ? 0 : myTrips.length,
      ),
    );
  }
}
