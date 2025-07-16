import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String messsage;
  final int statusCode;
  const Failure({required this.messsage, required this.statusCode});

  String get errorMessage => '$statusCode: $messsage';
  @override
  List<Object?> get props => [messsage, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.messsage, required super.statusCode});
}
