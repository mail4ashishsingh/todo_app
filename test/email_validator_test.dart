import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/screens/home_screen/test_class.dart';

void main() {
  // test("title", () {
  //   // Setup
  //
  //   // Run
  //
  //   // Verify
  // });

  test("empty email return error string", () {
    var result = EmailFieldValidator.validate("");
    expect(result, "Email can\'t be empty");
  });

  test("empty email return error string", () {
    var result = EmailFieldValidator.validate("email");
    expect(result, null);
  });
}
