class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? token;
  int? expiresin;

  UserModel(
      {this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.token,
        this.expiresin});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    token = json['token'];
    expiresin = json['expiresin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['token'] = this.token;
    data['expiresin'] = this.expiresin;
    return data;
  }
}
