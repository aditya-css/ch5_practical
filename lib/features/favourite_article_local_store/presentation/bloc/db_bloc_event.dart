import 'package:equatable/equatable.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class GetAllFavourites extends DatabaseEvent {
  const GetAllFavourites();
}

class DeleteAllFavourites extends DatabaseEvent {
  const DeleteAllFavourites();
}

class RemoveFavourite extends DatabaseEvent {
  final int id;

  const RemoveFavourite(this.id);

  @override
  List<Object> get props => [id];
}
