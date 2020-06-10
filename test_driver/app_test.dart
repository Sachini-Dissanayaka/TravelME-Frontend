import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group("Tour planning app testing", () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });

    Future<void> delay([int milliseconds = 250]) async {
      await Future<void>.delayed(Duration(milliseconds: milliseconds));
    }

    test('sign in anonymously, sign out', () async {
      final anonymousSignInButton = find.byValueKey('anonymous');
      await driver.waitFor(anonymousSignInButton);
      await delay(2000);
      await driver.tap(anonymousSignInButton);

      // find and tap logout button
      final logoutButton = find.byValueKey('signOut');
      await driver.waitFor(logoutButton);
      await delay(2000); // for video capture
      await driver.tap(logoutButton);

      await driver.waitFor(anonymousSignInButton);

      final anonymousSignInButton1 = find.byValueKey('anonymous');
      await driver.waitFor(anonymousSignInButton1);
      await delay(2000);
      await driver.tap(anonymousSignInButton1);
    });

    test('test direct to home',()async{
      final floatingButton = find.byValueKey('floatingButton');
      await driver.waitFor(floatingButton);
      await delay(10000);
      await driver.tap(floatingButton);
    });

    // test("Search city", () async{
    //   final cityFieldFinder = find.byValueKey('searchCity');
    //   final searchButtonFinder = find.byValueKey('search');
    //   await driver.waitFor(cityFieldFinder);
    //   await driver.tap(cityFieldFinder);
    //   await driver.enterText('Galle');
    //   await driver.waitFor(find.text('Galle'));
    //   await driver.waitFor(searchButtonFinder);
    //   await driver.tap(searchButtonFinder);
    //   await delay(10000);
    // });
  });
}
