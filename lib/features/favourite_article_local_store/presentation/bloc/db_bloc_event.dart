import 'package:equatable/equatable.dart';

abstract class DBEvent extends Equatable {
  const DBEvent();

  @override
  List<Object> get props => [];
}

class GetAllFavourites extends DBEvent {
  const GetAllFavourites();
}

class DeleteAllFavourites extends DBEvent {
  const DeleteAllFavourites();
}

class RemoveFavourite extends DBEvent {
  final int id;

  const RemoveFavourite(this.id);

  @override
  List<Object> get props => [id];
}
