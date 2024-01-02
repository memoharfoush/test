class User {
  int? userId;
  String? userEmail;
  String? userPassword;
  String? userPhone;
  String? userName;

  User(
      {this.userId,
      this.userEmail,
      this.userPassword,
      this.userPhone,
      this.userName});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "userId": userId,
      "user_name": userName,
      "user_email": userEmail,
      "user_password": userEmail,
      "user_phone": userEmail,
    };
    if (userId != null) map['userId'] = userId;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    userId = map['id'];
    userName = map['name'];
    userEmail = map['email'];
    userPassword = map['password'];
    userPhone = map['s_phone'];
  }
}
