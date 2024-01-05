import 'package:bloc/bloc.dart';
import 'package:clean_code_practice/core/error.dart';
import 'package:clean_code_practice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_practice/features/number_trivia/domain/usecases/abstract_usecase.dart';
import 'package:clean_code_practice/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_code_practice/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  NumberTriviaBloc(this.getConcreteNumberTrivia, this.getRandomNumberTrivia)
      : super(NumberTriviaInitial()) {
    on<GetConcreteNumberTriviaEvent>(_handleConcreteTriviaEvent);
    on<GetRandomNumberTriviaEvent>(_handleRandomTriviaEvent);
  }

  _handleConcreteTriviaEvent(GetConcreteNumberTriviaEvent event,
      Emitter<NumberTriviaState> emit) async {
    emit(NumberTriviaLoading());
    int? number = int.tryParse(event.number);
    if (number == null) {
      emit(NumberTriviaFailure("Invalid input"));
    } else {
      final eitherResponse =
          await getConcreteNumberTrivia.call(Params(data: number));
      eitherResponse.fold((left) {
        emit(NumberTriviaFailure(handleFailureMessage(left)));
      }, (right) {
        emit(NumberTriviaLoaded(right));
      });
    }
  }

  _handleRandomTriviaEvent(
      GetRandomNumberTriviaEvent event, Emitter<NumberTriviaState> emit) async {
    emit(NumberTriviaLoading());
    final eitherResponse = await getRandomNumberTrivia.call(NoParams());
    eitherResponse.fold((left) {
      emit(NumberTriviaFailure(handleFailureMessage(left)));
    }, (right) {
      emit(NumberTriviaLoaded(right));
    });
  }

  String handleFailureMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server failure';
    } else if (failure is CacheFailure) {
      return 'Cache Failure';
    } else {
      return 'Something went wrong';
    }
  }
}
