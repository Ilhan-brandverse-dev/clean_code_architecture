import 'package:clean_code_practice/core/network_info.dart';
import 'package:clean_code_practice/features/number_trivia/data/dataSources/num_trivia_local_data_source_abstract.dart';
import 'package:clean_code_practice/features/number_trivia/data/dataSources/num_trivia_remote_dara_source_abstract.dart';
import 'package:clean_code_practice/features/number_trivia/data/repositories/number_trivia_rep_impl.dart';
import 'package:clean_code_practice/features/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:clean_code_practice/features/number_trivia/presentation/bloc/bloc/number_trivia_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';

final sl = GetIt.instance;

void init() {
  //Bloc
  sl.registerFactory(() => NumberTriviaBloc(sl(), sl()));
  //Use case
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(repository: sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(repository: sl()));
  //Repo
  sl.registerLazySingleton<NumberTriviaRepo>(
    () => NumberTriviaRepoImpl(
      remoteSource: sl(),
      localSource: sl(),
      networkInfo: sl(),
    ),
  );

  //data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(),
  );

//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  sl.registerLazySingleton(() => Dio());
}
