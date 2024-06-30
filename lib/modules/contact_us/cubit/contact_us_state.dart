part of 'contact_us_cubit.dart';

@immutable
sealed class ContactUsState {}

final class ContactUsInitial extends ContactUsState {}
final class SaveContactUsLoading extends ContactUsState {}
final class SaveContactUsError extends ContactUsState {
  final String msg;

  SaveContactUsError({required this.msg});
}
final class SaveContactUsSuccess extends ContactUsState {
  final String msg;

  SaveContactUsSuccess({required this.msg});
}
