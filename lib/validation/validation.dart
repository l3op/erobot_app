
String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  print(value);
  if (value.isEmpty)
    return 'Please enter your email address';
  else {
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address';
    else
      return null;
  }
}

String validatePassword(String value) {
  RegExp capiltalLetter = RegExp(r'^(?=.*[A-Z])');
  RegExp lowerCase = RegExp(r'(?=.*[a-z])');
  RegExp oneDigit = RegExp(r'(?=.*?[0-9])');
  RegExp specialChar = RegExp(r'(?=.*?[!@#\$&*~])');
  RegExp eightDigit = RegExp(r'.{8,}');

  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);

  print(value);
  if (value.isEmpty) {
    return 'Please enter your password';
  } else {
    if (!capiltalLetter.hasMatch(value))
      return 'Should contain at least one upper case';
    else if (!lowerCase.hasMatch(value))
      return 'Should contain at least one lower case';
    else if (!oneDigit.hasMatch(value))
      return 'Should contain at least one digit';
    else if (!specialChar.hasMatch(value))
      return 'Should contain at least one Special character';
    else if (!eightDigit.hasMatch(value))
      return 'Should at least 8 characters';
    else if (!regex.hasMatch(value))
      return 'Enter valid password';
    else
      return null;
  }
  // r'^
  // (?=.*[A-Z])       // should contain at least one upper case
  // (?=.*[a-z])       // should contain at least one lower case
  // (?=.*?[0-9])          // should contain at least one digit
  // (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
  // $
}
