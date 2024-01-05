import 'package:clean_code_practice/core/exceptions.dart';
import 'package:clean_code_practice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dio/dio.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Dio dio;
  NumberTriviaRemoteDataSourceImpl({required this.dio});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    try {
      Response response = await dio.get('http://numbersapi.com/$number');
      if (response.statusCode == 200) {
        return NumberTriviaModel.withTextAndNumber(response.data, number);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    try {
      Response response = await dio.get('http://numbersapi.com/random');
      if (response.statusCode == 200) {
        return NumberTriviaModel.withTextAndNumber(response.data, 0);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
