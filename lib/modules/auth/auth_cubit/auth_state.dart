part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class ObscurePasswordChanged extends AuthState {}
final class LoginLoading extends AuthState {}
final class LoginError extends AuthState {
  final String msg;

  LoginError({required this.msg});
}
final class LoginSuccess extends AuthState {
  final String msg;

  LoginSuccess({required this.msg});
}
