import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/core/helpers/extensions/date_format_extensions.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/home_provider/models/job_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../core/cache_helper/cache_storage.dart';
import '../../../core/ui_helper/custom_date_picker.dart';
import '../../home_customer/data/repo/home_customer_repo.dart';

part 'create_project_job_state.dart';

class CreateProjectJobCubit extends Cubit<CreateProjectJobState> {
  CreateProjectJobCubit({
    required this.cacheStorage,
    required this.homeCustomerRepo,
    required this.api,
  }) : super(CreateProjectJobInitial());
  final CacheStorage cacheStorage;
  final HomeCustomerRepo homeCustomerRepo;
  final ApiConsumer api;
  final ImagePicker picker = ImagePicker();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  XFile? image;

  pickImage() async {
    var oldImage = image;
    try {
      var imagesPicked = await picker.pickImage(
        source: ImageSource.gallery,
      );
      image = imagesPicked;
      if (imagesPicked == null) {
        image = oldImage;
      }
      emit(PickedImageSuccess(image: imagesPicked));
    } catch (ex) {
      log(ex.toString());
      // image = null;
    }
  }

  Future<void> addNewProject() async {
    emit(AddNewProjectLoading());
    var res = await homeCustomerRepo.addNewProject({
      'files': image,
      'Title': titleController.text,
      'Description': descriptionController.text
    });
    res.fold(
      (l) => emit(AddNewProjectError(msg: l.model.message ?? '')),
      (r) => emit(AddNewProjectSuccess()),
    );
  }

  addNewJob() async {
    emit(AddNewProjectLoading());

    var imageInM = await MultipartFile.fromFile(File(image!.path).path,
        filename: image!.name.split('/').last);
    await api.post(EndPoints.jobs, isFromData: true, data: {
      'title': titleController.text,
      'description': descriptionController.text,
      'startsAt': startDateController.text,
      'enndsAt': endDateController.text,
      'ImageFile': imageInM,
    }).then((value) {
      emit(AddNewProjectSuccess());
    }).catchError((onError) {
      emit(AddNewProjectError(msg: 'Error While Add Job'));
    });
  }

  bool checkAllValuesForCreateProject(bool isCreateProject) {
    if (!isCreateProject) {
      return titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          image != null &&
          startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty;
    }
    return titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        image != null;
  }

  Future<void> onTapStartDate(BuildContext context) async {
    var date = await buildCustomShowDatePicker(context,
        initialDate: startDateController.text.isEmpty
            ? DateTime.now()
            : DateFormat().formatFromYyyymmdd(startDateController.text),
        firstDate: DateTime.now());
    try {
      startDateController.text = DateFormat().formatToYyyymmdd(date!);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> onTapEndDate(BuildContext context) async {
    var date = await buildCustomShowDatePicker(
      context,
      initialDate: endDateController.text.isEmpty
          ? DateTime.now()
          : DateFormat().formatFromYyyymmdd(endDateController.text),
      firstDate: DateTime.now(),
    );
    try {
      endDateController.text = DateFormat().formatToYyyymmdd(date!);
    } catch (e) {
      log(e.toString());
    }
  }

  updateProviderJob(int jobId) async {
    emit(UpdateJobLoading());
    var imageInM = await MultipartFile.fromFile(File(image!.path).path,
        filename: image!.name.split('/').last);
    await api.put('${EndPoints.jobs}/$jobId', isFromData: true, data: {
      'title': titleController.text,
      'description': descriptionController.text,
      'startsAt': startDateController.text,
      'enndsAt': endDateController.text,
      'ImageFile': imageInM,
    }).then((value) {
      emit(UpdateJobSuccess(msg: 'Job Updated Success'));
    }).catchError((onError) {
      emit(UpdateJobError(msg: 'Error While Updated Job'));
    });
  }

  onOpenUpdateJob(JobModel job) {
    titleController.text = job.title ?? '';
    descriptionController.text = job.description ?? '';
    startDateController.text = job.startsAt ?? '';
    endDateController.text = job.enndsAt ?? '';
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    return super.close();
  }
}
