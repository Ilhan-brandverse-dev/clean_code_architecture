import 'package:clean_code_practice/core/error.dart';
import 'package:clean_code_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_practice/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:clean_code_practice/features/number_trivia/domain/usecases/abstract_usecase.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepo repository;
  GetRandomNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRadomNumberTrivia();
  }
}
