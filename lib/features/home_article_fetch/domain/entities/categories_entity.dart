import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final List<String> names;

  const Categories(this.names);

  @override
  List<Object?> get props => [names];

  @override
  bool get stringify => true;
}
