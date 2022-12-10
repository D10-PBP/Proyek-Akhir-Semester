class UpdateUser {
  String username;
  String firstName;
  String lastName;
  String telephone;
  String whatsapp;
  String line;

  UpdateUser({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.telephone,
    required this.whatsapp,
    required this.line,
  });

  Map<String, dynamic> toJson(String? csrf) => {
        'csrfmiddlewaretoken': csrf,
        'first_name': firstName,
        'last_name': lastName,
        'telephone': telephone,
        'whatsapp': whatsapp,
        'line': line,
      };
}
