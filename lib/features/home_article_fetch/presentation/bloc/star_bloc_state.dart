import 'package:equatable/equatable.dart';

abstract class StarBlocState extends Equatable {
  const StarBlocState();

  @override
  List<Object> get props => [];
}

class StarInitial extends StarBlocState {
  const StarInitial();
}

class StarLoading extends StarBlocState {
  const StarLoading();
}

class StarSuccess extends StarBlocState {
  final num index;

  const StarSuccess(this.index);

  @override
  List<Object> get props => [index];
}

class StarFailed extends StarBlocState {
  final String message;

  const StarFailed(this.message);

  @override
  List<Object> get props => [message];
}
