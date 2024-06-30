class ProjectModel {
  int? id;
  String? title;
  String? description;
  int? createdById;
  String? status;
  String? imageName;
  List<Offers>? offers;

  ProjectModel(
      {this.id,
      this.title,
      this.description,
      this.createdById,
      this.status,
      this.imageName,
      this.offers});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdById = json['createdById'];
    status = json['status'];
    imageName = json['imageName'];
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdById'] = this.createdById;
    data['status'] = this.status;
    data['imageName'] = this.imageName;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  int? id;
  String? message;
  String? status;
  String? providerName;

  Offers({
    this.id,
    this.message,
    this.status,
    this.providerName,
  });

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    status = json['status'];
    providerName = json['providerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['status'] = this.status;
    data['providerName'] = this.providerName;
    return data;
  }
}
