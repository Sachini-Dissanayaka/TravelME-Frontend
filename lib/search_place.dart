import 'package:flutter/material.dart';
import 'HeadOne.dart';
import 'sign_in.dart';
// import 'Places.dart';

class SearchPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('TravelME'),
        backgroundColor: Colors.purple,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavTrip()),
                );
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple[50], Colors.purple[100]],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey " + name + ",",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            new Text(
              'Find a place you want to visit',
              style: new TextStyle(color: Colors.purple, fontSize: 20.0),
            ),
            SizedBox(height: 40),

            new TextFormField(
              decoration: new InputDecoration(
                labelText: "Search a Place",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "City cannot be empty";
                } else {
                  return null;
                }
              },
              style: new TextStyle(
                fontFamily: "Poppins",
                color: Colors.deepPurple,
                fontSize: 20.0,
              ),
            ),
            // IconButton(icon: Icon(Icons.search),onPressed:() {
            //   Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Place()),
            // );
            // },)
          ],
        ),
      ),
    );
  }
}

// class displayImage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: ListView.builder(
//           itemBuilder: (context, index) {
//             return Card(
//               child: Padding(
//                 padding: const EdgeInsets.only(top:32.0,bottom:32.0,right:16.0,left:16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text('Note Title',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//                     Text('Note Text',style: TextStyle(color:Colors.grey.shade600),),
//                   ],
//                 ),
//               ),
//             );
//           },
//           itemCount: 50,
//         ));
//   }
// }
