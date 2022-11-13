class Validator {
  static String? nonEmptyField(
    String? value, {
    String message = 'Field cannot be empty',
  }) {
    if (value!.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  static String? password(String? value, {String message = 'Enter password'}) {
    if (value == null || value.isEmpty) {
      return message;
    } else if (value.length < 8) {
      return 'Password should be atleast 8 characters long';
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*])')
        .hasMatch(value)) {
      return 'Password should contain at least one special character,a number and a capital letter';
    } else {
      return null;
    }
  }

  static String? emailValidator(String? value) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Field cannot be blank';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }
}
