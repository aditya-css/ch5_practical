import 'package:mobx/mobx.dart';

part 'bottom_nav_index_store.g.dart';

class BottomNavStore = _BottomNavStore with _$BottomNavStore;

abstract class _BottomNavStore with Store {
  @readonly
  int _index = 2;

  @action
  void onItemTap(int newIndex) => _index = newIndex;
}
