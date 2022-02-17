class User {
  String firstname = "";
  String lastname = "";
  String username = "";
  String phone = "";
  String email = "";
  String password = "";

  toJson() {
    return {
      'firstname': firstname.toString(),
      'username': username.toString(),
      'lastname': lastname.toString(),
      'phone': phone.toString(),
      'email': email.toString(),
      'password': password.toString(),
    };
  }
}
