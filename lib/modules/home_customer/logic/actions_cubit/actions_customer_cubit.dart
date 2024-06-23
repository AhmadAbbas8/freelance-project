import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/home_customer/data/model/project_model.dart';
import 'package:grad_project/modules/home_customer/data/repo/action_customer_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/service_locator/service_locator.dart';

part 'actions_customer_state.dart';

class ActionsCustomerCubit extends Cubit<ActionsCustomerState> {
  ActionsCustomerCubit({
    required this.actionsCustomerRepo,
  }) : super(ActionsCustomerInitial());
  final ActionsCustomerRepo actionsCustomerRepo;
  final api = ServiceLocator.instance<ApiConsumer>();

  acceptOffer({
    required String projectId,
    required String offerId,
  }) async {
    emit(AcceptOfferLoading());
    var res = await actionsCustomerRepo.acceptOffer(
        projectId: projectId, offerId: offerId);
    res.fold(
      (l) => emit(AcceptOfferError(msg: l.model.message ?? '')),
      (r) => emit(AcceptOfferSuccess()),
    );
  }

  final messageController = TextEditingController();

  addNewOffer(String projectId) async {
    emit(AddNewOfferLoading());
    api.post(
      '${EndPoints.addNewProjects}/$projectId/Offres',
      data: {
        "Message": messageController.text,
      },
    ).then((value) {
      messageController.clear();

      emit(AddNewOfferSuccess(offer: Offers.fromJson(value.data)));
    }).catchError((onError) {
      log(onError.toString());
      if (onError is DioException) {
        if (onError.response?.statusCode == 400) {
          emit(AddNewOfferError(
              msg: onError.response?.data['errors'][0]['description']));
        }
        return;
      }
      emit(AddNewOfferError(
          msg: 'Project Assigned to another provider Or Completed'));
    });
  }

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
