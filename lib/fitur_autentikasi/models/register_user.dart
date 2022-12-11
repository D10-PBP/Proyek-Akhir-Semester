class RegisterUser {
  String username;
  String password1;
  String password2;
  String firstName;
  String lastName;
  String email;
  String telephone;
  String whatsapp;
  String line;

  RegisterUser({
    required this.username,
    required this.password1,
    required this.password2,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.whatsapp,
    required this.line,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password1': password1,
        'password2': password2,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'telephone': telephone,
        'whatsapp': whatsapp,
        'line': line,
      };
}
