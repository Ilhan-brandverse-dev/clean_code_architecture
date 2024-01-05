import 'dart:convert';

import 'package:clean_code_practice/core/exceptions.dart';
import 'package:clean_code_practice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String cacheKey = 'CACHED_NUMBER_TRIVIA';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setString(
        cacheKey, jsonEncode(triviaToCache.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(cacheKey);
    if (data != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(data)));
    } else {
      throw CacheException();
    }
  }
}
