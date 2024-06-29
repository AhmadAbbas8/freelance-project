part of 'home_customer_cubit.dart';

@immutable
sealed class HomeCustomerState {}

final class HomeCustomerInitial extends HomeCustomerState {}
final class MakeProjectAssignedOrDoneLoading extends HomeCustomerState {}
final class MakeProjectAssignedOrDoneSuccess extends HomeCustomerState {
  final String msg;

  MakeProjectAssignedOrDoneSuccess({required this.msg});
}
final class MakeProjectAssignedOrDoneError extends HomeCustomerState {
  final String msg;

  MakeProjectAssignedOrDoneError({required this.msg});
}
final class FetchCategoriesLoading extends HomeCustomerState {}

final class FetchCategoriesError extends HomeCustomerState {
  final String msg;

  FetchCategoriesError({required this.msg});
}

final class FetchCategoriesSuccess extends HomeCustomerState {}

final class ChangeBottomNavIndex extends HomeCustomerState {}

final class FetchCurrentProjectCustomerLoading extends HomeCustomerState {}

final class FetchCurrentProjectCustomerError extends HomeCustomerState {
  final String msg;

  FetchCurrentProjectCustomerError({required this.msg});
}

final class FetchCurrentProjectCustomerSuccess extends HomeCustomerState {
  final List<ProjectModel> projects;

  FetchCurrentProjectCustomerSuccess({required this.projects});
}
