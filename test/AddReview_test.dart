import 'package:test/test.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:tour_planner/AddReview.dart';

void main() {
  enableFlutterDriverExtension();
  
  test('empty city returns error string', () {
    var result = CityReviewFieldValidator.validate('');
    expect(result, 'City can\'t be empty');
  });

  test('non-empty city returns null', () {
    var result = CityReviewFieldValidator.validate('city');
    expect(result, null);
  });
  
  test('empty name returns error string', () {
    var result = NameFieldValidator.validate('');
    expect(result, 'Name can\'t be empty');
  });

  test('non-empty name returns null', () {
    var result = NameFieldValidator.validate('name');
    expect(result, null);
  });
  
  test('empty review returns error string', () {
    var result = ReviewFieldValidator.validate('');
    expect(result, 'Review can\'t be empty');
  });

  test('non-empty review returns null', () {
    var result = ReviewFieldValidator.validate('review');
    expect(result, null);
  });
}
