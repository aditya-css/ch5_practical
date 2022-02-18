// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_index_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BottomNavStore on _BottomNavStore, Store {
  final _$_indexAtom = Atom(name: '_BottomNavStore._index');

  int get index {
    _$_indexAtom.reportRead();
    return super._index;
  }

  @override
  int get _index => index;

  @override
  set _index(int value) {
    _$_indexAtom.reportWrite(value, super._index, () {
      super._index = value;
    });
  }

  final _$_BottomNavStoreActionController =
      ActionController(name: '_BottomNavStore');

  @override
  void onItemTap(int newIndex) {
    final _$actionInfo = _$_BottomNavStoreActionController.startAction(
        name: '_BottomNavStore.onItemTap');
    try {
      return super.onItemTap(newIndex);
    } finally {
      _$_BottomNavStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
