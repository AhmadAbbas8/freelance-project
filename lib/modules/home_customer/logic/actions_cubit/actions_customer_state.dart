part of 'actions_customer_cubit.dart';

@immutable
sealed class ActionsCustomerState {}

final class ActionsCustomerInitial extends ActionsCustomerState {}

final class AddNewOfferLoading extends ActionsCustomerState {}

final class AddNewOfferError extends ActionsCustomerState {
  final String msg;

  AddNewOfferError({required this.msg});
}

final class AddNewOfferSuccess extends ActionsCustomerState {
  final Offers offer;

  AddNewOfferSuccess({required this.offer});
}

final class AcceptOfferLoading extends ActionsCustomerState {}

final class AcceptOfferError extends ActionsCustomerState {
  final String msg;

  AcceptOfferError({required this.msg});
}

final class AcceptOfferSuccess extends ActionsCustomerState {}
