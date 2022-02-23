// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CounterStore on _CounterStore, Store {
  final _$_countAtom = Atom(name: '_CounterStore._count');

  int get count {
    _$_countAtom.reportRead();
    return super._count;
  }

  @override
  int get _count => count;

  @override
  set _count(int value) {
    _$_countAtom.reportWrite(value, super._count, () {
      super._count = value;
    });
  }

  final _$_bgColorAtom = Atom(name: '_CounterStore._bgColor');

  Color get bgColor {
    _$_bgColorAtom.reportRead();
    return super._bgColor;
  }

  @override
  Color get _bgColor => bgColor;

  @override
  set _bgColor(Color value) {
    _$_bgColorAtom.reportWrite(value, super._bgColor, () {
      super._bgColor = value;
    });
  }

  final _$_CounterStoreActionController =
      ActionController(name: '_CounterStore');

  @override
  void updateCount(CounterActions type) {
    final _$actionInfo = _$_CounterStoreActionController.startAction(
        name: '_CounterStore.updateCount');
    try {
      return super.updateCount(type);
    } finally {
      _$_CounterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBackgroundColor(Color newColor) {
    final _$actionInfo = _$_CounterStoreActionController.startAction(
        name: '_CounterStore.changeBackgroundColor');
    try {
      return super.changeBackgroundColor(newColor);
    } finally {
      _$_CounterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
