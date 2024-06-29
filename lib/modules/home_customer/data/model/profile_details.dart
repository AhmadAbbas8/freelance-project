import 'package:grad_project/modules/home_provider/models/job_model.dart';

class ProfileDetails {
  int? id;
  String? name;
  String? phoneNumber;
  String? governorate;
  String? birthDate;
  String? field;
  int? experienceYears;
  String? address;
  List<JobModel>? jobs;

  ProfileDetails(
      {this.id,
        this.name,
        this.phoneNumber,
        this.governorate,
        this.birthDate,
        this.field,
        this.experienceYears,
        this.address,
        this.jobs});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    governorate = json['governorate'];
    birthDate = json['birthDate'];
    field = json['field'];
    experienceYears = json['experienceYears'];
    address = json['address'];
    if (json['jobs'] != null) {
      jobs = <JobModel>[];
      json['jobs'].forEach((v) {
        jobs!.add(new JobModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['governorate'] = this.governorate;
    data['birthDate'] = this.birthDate;
    data['field'] = this.field;
    data['experienceYears'] = this.experienceYears;
    data['address'] = this.address;
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

