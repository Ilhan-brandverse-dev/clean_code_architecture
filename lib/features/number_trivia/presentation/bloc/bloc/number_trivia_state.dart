part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  final List<Object> properties;
  const NumberTriviaState({this.properties = const []});

  @override
  List<Object> get props => properties;
}

class NumberTriviaInitial extends NumberTriviaState {}

class NumberTriviaLoading extends NumberTriviaState {}

class NumberTriviaLoaded extends NumberTriviaState {
  final NumberTrivia trivia;
  NumberTriviaLoaded(this.trivia) : super(properties: [trivia]);
}

class NumberTriviaFailure extends NumberTriviaState {
  final String message;
  NumberTriviaFailure(this.message) : super(properties:[message]);
}
