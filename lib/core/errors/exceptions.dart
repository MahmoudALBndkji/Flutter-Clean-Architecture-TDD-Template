import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  final String errorMessage;
  final int statusCode;

  const APIException({required this.errorMessage, required this.statusCode});

  @override
  String toString() {
    return '$statusCode: $errorMessage';
  }

  @override
  List<Object?> get props => [errorMessage, statusCode];
}
