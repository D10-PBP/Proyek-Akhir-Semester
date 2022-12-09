class RegisterUser {
  String username;
  String password1;
  String password2;
  String first_name;
  String last_name;
  String email;
  String telephone;
  String whatsapp;
  String line;

  RegisterUser({
    required this.username,
    required this.password1,
    required this.password2,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.telephone,
    required this.whatsapp,
    required this.line,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password1': password1,
        'password2': password2,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'telephone': telephone,
        'whatsapp': whatsapp,
        'line': line,
      };
}
