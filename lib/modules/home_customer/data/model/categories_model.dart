class CategoriesModel {
  int? id;
  String? title;
  String? description;
  String? imageName;
  List<Providers>? providers;

  CategoriesModel(
      {this.id, this.title, this.description, this.imageName, this.providers});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imageName = json['imageName'];
    if (json['providers'] != null) {
      providers = <Providers>[];
      json['providers'].forEach((v) {
        providers!.add(new Providers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageName'] = this.imageName;
    if (this.providers != null) {
      data['providers'] = this.providers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Providers {
  int? id;
  String? firstName;
  String? lastName;

  Providers({this.id, this.firstName, this.lastName});

  Providers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
