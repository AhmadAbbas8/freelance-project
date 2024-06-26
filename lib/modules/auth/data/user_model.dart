class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? token;
  int? expiresin;
  String? refreshToken;
  String? refreshTokenExpiration;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.role,
      this.token,
      this.expiresin,
      this.refreshToken,
      this.refreshTokenExpiration});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    token = json['token'];
    expiresin = json['expiresin'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiration = json['refreshTokenExpiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['role'] = this.role;
    data['token'] = this.token;
    data['expiresin'] = this.expiresin;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpiration'] = this.refreshTokenExpiration;
    return data;
  }
}
