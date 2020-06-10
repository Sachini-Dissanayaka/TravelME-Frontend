import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tour_planner/main.dart';
import 'package:tour_planner/AddTrip.dart';
import 'package:tour_planner/login_page.dart';
import 'package:tour_planner/first_screen.dart';
import 'package:tour_planner/sign_in.dart';


void main() {
  
  testWidgets('Main UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.byType(LoginPage), findsOneWidget);
    
  });
  
  testWidgets('Login page UI test', (WidgetTester tester) async {
    // await tester.pumpWidget(LoginPage());
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginPage(),     
        ),
      )
    );
    expect(find.byType(LoginPage), findsOneWidget);
    expect(
        find.text("Welcome to TravelME"),
        findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(OutlineButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
  });
  // testWidgets('First screen UI test', (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: Scaffold(
  //         body: FirstScreen(),     
  //       ),
  //     )
  //   );
  //   expect(find.byType(FirstScreen), findsOneWidget);
  //   //expect(find.byType(FloatingActionButton), findsOneWidget);
  //   //expect(find.text("My Profile"),findsOneWidget);
  //   //expect(find.text("NAME"),findsOneWidget);
  //   //expect(find.text("EMAIL"),findsOneWidget);
  //   expect(find.byType(RaisedButton), findsOneWidget);
  // });
 
}
