import 'package:equatable/equatable.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

class Initial extends DatabaseState {
  const Initial();
}

class Loading extends DatabaseState {
  const Loading();
}

class Complete<T extends Object> extends DatabaseState {
  final T data;

  const Complete(this.data);

  @override
  List<Object> get props => [data];
}

class Failed extends DatabaseState {
  final String? exclaim, title;
  final String message;

  const Failed({
    this.exclaim,
    this.title,
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
