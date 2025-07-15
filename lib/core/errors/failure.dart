abstract class Failure {
  final String messsage;
  final int statusCode;

  Failure({required this.messsage, required this.statusCode});

  String get errorMessage => '$statusCode: $messsage';
}

class APIFailuer extends Failure {
  APIFailuer({required super.messsage, required super.statusCode});
}
