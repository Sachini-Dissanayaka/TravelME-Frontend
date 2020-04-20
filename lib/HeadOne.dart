import 'package:flutter/material.dart';
import 'package:tour_planner/first_screen.dart';
import 'Help.dart';
import 'home.dart';
import 'MyTrip.dart';
import 'Places.dart';

class NavHome extends StatefulWidget {
  @override
  _NavHomePageState createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Text(
                    'TravelME Navigator',
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(children: [
                ListTile(
                  leading: Icon(
                    Icons.beach_access,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'My Trips',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyTrip()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.place,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'Attractive Places',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Place()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'Map',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    // Then close the drawer.
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.purple,
                  ),
                  title: Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstScreen()),
                    );
                  },
                ),
              ]),
            )
          ],
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('TravelME'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: "Home",
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: "Help",
                    icon: Icon(Icons.help),
                  )
                ],
                controller: _tabController,
              ),
              backgroundColor: Colors.purple,
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Home(),
            Help(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
