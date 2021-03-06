import 'package:test/test.dart';
import 'package:tour_planner/Home.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();
  test('empty city returns error string', () {
    var result = CityFieldValidator.validate('');
    expect(result, 'City can\'t be empty');
  });

  test('non-empty city returns null', () {
    var result = CityFieldValidator.validate('city');
    expect(result, null);
  });


}
