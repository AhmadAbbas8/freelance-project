import 'package:equatable/equatable.dart';

import 'default_response.dart';

abstract class Failure extends Equatable {
  final DefaultResponse model;

  const Failure({required this.model});

  @override
  List<Object?> get props => [model];
}

class OfflineFailure extends Failure {
  final DefaultResponse model;

  const OfflineFailure([
    this.model = const DefaultResponse(
        message: 'No internet connection ⚠', statusCode: 4),
  ]) : super(model: model);

  @override
  List<Object?> get props => [model];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.model});

  // : super(errorModel: errorModel);

  @override
  List<Object?> get props => [model];
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({required super.model});

  @override
  List<Object?> get props => [];
}
