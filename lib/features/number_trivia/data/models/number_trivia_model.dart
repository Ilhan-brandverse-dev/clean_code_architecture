import 'package:clean_code_practice/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required super.number, required super.text});

  factory NumberTriviaModel.withTextAndNumber(String json, int number) {
    return NumberTriviaModel(number: number, text: json);
  }

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
        number: (json['number'] as num).toInt(), text: json['text']);
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'number': number,
      };
}
