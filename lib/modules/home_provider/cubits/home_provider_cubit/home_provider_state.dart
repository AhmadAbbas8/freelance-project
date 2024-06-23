part of 'home_provider_cubit.dart';

@immutable
sealed class HomeProviderState {}

final class HomeProviderInitial extends HomeProviderState {}
final class ChangeCurrentIndex extends HomeProviderState {}
final class GetAllProjectProviderLoading extends HomeProviderState {}
final class GetAllProjectProviderError extends HomeProviderState {}
final class GetAllProjectProviderSuccess extends HomeProviderState {}
