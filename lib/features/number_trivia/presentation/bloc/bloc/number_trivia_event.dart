part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  final List<Object> properties;
  const NumberTriviaEvent({this.properties = const []});

  @override
  List<Object> get props => properties;
}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String number;
  GetConcreteNumberTriviaEvent(this.number) : super(properties: [number]);
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent {}
