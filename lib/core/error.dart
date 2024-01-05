import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  final List<Object>? properties;
  const Failure({this.properties});

  @override
  List<Object?> get props => properties ?? [];
}

// Failures are exactly map like exceptions so we can pass it from repository
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
