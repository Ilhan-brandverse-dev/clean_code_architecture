import 'package:clean_code_practice/core/error.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param params);
}

class NoParams {}

class Params<T> {
  final T data;
  Params({required this.data});
}
