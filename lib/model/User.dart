class UserModel {
  final String username, password, email, instagram;
  final int id_user;

  UserModel(
      {required this.username,
      required this.password,
      required this.email,
      required this.instagram,
      required this.id_user});

  factory UserModel.fromJSON(Map parsedJson) {
    return UserModel(
        id_user: parsedJson['id_user'],
        username: parsedJson['username'],
        password: parsedJson['password'],
        instagram: parsedJson['instagram'],
        email: parsedJson['email']);
  }
}
