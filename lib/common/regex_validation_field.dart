String? validateEmail(String? text) {
  RegExp emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$');
  if (text == null || text.isEmpty) {
    return "Please enter your email";
  }
  if (!emailRegex.hasMatch(text)) {
    return "Please enter a valid email address";
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Password cannot be empty";
  }
  if (password.length < 8) {
    return "Password must be at least 8 characters long";
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return "Password must contain at least one uppercase letter";
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return "Password must contain at least one lowercase letter";
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return "Password must contain at least one digit";
  }
  return null;
}

String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return "Name cannot be empty";
  }
  if (name.length < 3) {
    return "Name must be at least 3 characters long";
  }
  if (name.length > 50) {
    return "Name must be at most 50 characters long";
  }
  return null;
}
