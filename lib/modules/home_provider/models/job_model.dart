class JobModel {
  int? id;
  String? title;
  String? description;
  String? startsAt;
  String? enndsAt;
  String? imageName;

  JobModel(
      {this.id,
        this.title,
        this.description,
        this.startsAt,
        this.enndsAt,
        this.imageName});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startsAt = json['startsAt'];
    enndsAt = json['enndsAt'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['startsAt'] = this.startsAt;
    data['enndsAt'] = this.enndsAt;
    data['imageName'] = this.imageName;
    return data;
  }
}
