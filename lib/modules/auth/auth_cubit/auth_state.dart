part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ObscurePasswordChanged extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpError extends AuthState {
  final String msg;

  SignUpError({required this.msg});
}

final class SignUpSuccess extends AuthState {
  final String msg;
  final String role;

  SignUpSuccess({required this.msg, required this.role});
}

final class LoginLoading extends AuthState {}

final class LoginError extends AuthState {
  final String msg;

  LoginError({required this.msg});
}

final class LoginSuccess extends AuthState {
  final String msg;
  final String role;

  LoginSuccess({required this.msg, required this.role});
}
