import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/failure.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
