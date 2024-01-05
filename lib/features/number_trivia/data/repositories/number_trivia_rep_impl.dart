import 'package:clean_code_practice/core/error.dart';
import 'package:clean_code_practice/core/exceptions.dart';
import 'package:clean_code_practice/core/network_info.dart';
import 'package:clean_code_practice/features/number_trivia/data/dataSources/num_trivia_local_data_source_abstract.dart';
import 'package:clean_code_practice/features/number_trivia/data/dataSources/num_trivia_remote_dara_source_abstract.dart';
import 'package:clean_code_practice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_practice/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:dartz/dartz.dart';

typedef ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

//Repo implementation is never directly exposed to outer world or any 3rd party library
class NumberTriviaRepoImpl implements NumberTriviaRepo {
  final NumberTriviaRemoteDataSource remoteSource;
  final NumberTriviaLocalDataSource localSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepoImpl(
      {required this.localSource,
      required this.networkInfo,
      required this.remoteSource});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getTrivia(
        () async => await remoteSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRadomNumberTrivia() {
    return _getTrivia(() async => await remoteSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      ConcreteOrRandomChooser getTrivia) async {
    try {
      NumberTriviaModel model;
      if (await networkInfo.isConnected) {
        model = await getTrivia();
        await localSource.cacheNumberTrivia(model);
      } else {
        model = await localSource.getLastNumberTrivia();
      }
      return Right(model);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
