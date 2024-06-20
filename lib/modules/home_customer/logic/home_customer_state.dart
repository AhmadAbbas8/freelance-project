part of 'home_customer_cubit.dart';

@immutable
sealed class HomeCustomerState {}

final class HomeCustomerInitial extends HomeCustomerState {}
final class FetchCategoriesLoading extends HomeCustomerState {}
final class FetchCategoriesError extends HomeCustomerState {
  final String msg;

  FetchCategoriesError({required this.msg});
}
final class FetchCategoriesSuccess extends HomeCustomerState {}
