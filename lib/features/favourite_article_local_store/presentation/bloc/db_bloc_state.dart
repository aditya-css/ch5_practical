/*abstract class DBState {
  const DBState();
}

class Initial extends DBState {
  const Initial();
}

class Loading extends DBState {
  const Loading();
}

class Complete<T extends Object> extends DBState {
  final T data;

  const Complete(this.data);
}

class Failed extends DBState {
  final String? exclaim, title;
  final String message;

  const Failed({
    this.exclaim,
    this.title,
    required this.message,
  });
}*/

import 'package:equatable/equatable.dart';

abstract class DBState extends Equatable {
  const DBState();

  @override
  List<Object> get props => [];
}

class Initial extends DBState {
  const Initial();
}

class Loading extends DBState {
  const Loading();
}

class Complete<T extends Object> extends DBState {
  final T data;

  const Complete(this.data);

  @override
  List<Object> get props => [data];
}

class Failed extends DBState {
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
