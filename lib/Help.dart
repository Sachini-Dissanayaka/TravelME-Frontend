import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:tour_planner/first_screen.dart';
import 'home.dart';

class Help extends StatelessWidget {

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
    Widget textSection = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Home - You can go to home page\nMe - You can see your details\nTrips-You can create a trip and see your previous trips\nCall-You can make a call\nMap - You can load your Google Map',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );
    Widget homeSearch = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Here enter a city and click search icon then you can see near places and hotels.',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );
    Widget create = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Here you can create a trip and add reviews.',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );
    Widget trip = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Here you can create a trip or see your previous trips.',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );
    Widget own = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Here you can create your own trip.',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );
    Widget searchTrip = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Here enter a city and click search icon to find places around the city.',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );
    Widget ownTrip = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Here press red color star icon to select places.',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );
    Widget hotelAround = Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'In the planned trip page using this link you can find hotels around the current place.',
        softWrap: true,
        style: TextStyle(fontSize:16),
      ),
    );

    return MaterialApp(
      title: 'TravelMe',
      home: Scaffold(
        appBar: new AppBar(
          title: new Text('TravelME'),
          backgroundColor: Colors.green[900],
        ),
        body: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                "Help Center",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/bottom.JPG',
              width: 100,
              height: 50,
              fit: BoxFit.cover,
            ),
            textSection,
            SizedBox(height: 20),
            Image.asset(
              'assets/homeSearch.JPG',
              width: 80,
              height: 200,
              fit: BoxFit.cover,
            ),
            homeSearch,
            SizedBox(height: 20),
            Image.asset(
              'assets/create.JPG',
              width: 50,
              height: 100,
            ),
            create,
            SizedBox(height: 20),
            Image.asset(
              'assets/trip.JPG',
              width: 100,
              height: 70,
              fit: BoxFit.cover,
            ),
            trip,
            Image.asset(
              'assets/own.JPG',
              width: 100,
              height: 70,
              fit: BoxFit.cover,
            ),
            own,
            Image.asset(
              'assets/searchTrip.JPG',
              width: 80,
              height: 200,
              fit: BoxFit.cover,
            ),
            searchTrip,
            Image.asset(
              'assets/selectPlace.JPG',
              width: 100,
              height: 200,
              fit: BoxFit.cover,
            ),
            ownTrip,
            Image.asset(
              'assets/hotelAround.JPG',
              width: 100,
              height: 60,
              fit: BoxFit.cover,
            ),
            hotelAround,
          ],
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
      ),
    );
  }
}
