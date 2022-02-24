// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SwitchStore on _SwitchStore, Store {
  final _$_switchStateValueAtom = Atom(name: '_SwitchStore._switchStateValue');

  bool get switchStateValue {
    _$_switchStateValueAtom.reportRead();
    return super._switchStateValue;
  }

  @override
  bool get _switchStateValue => switchStateValue;

  @override
  set _switchStateValue(bool value) {
    _$_switchStateValueAtom.reportWrite(value, super._switchStateValue, () {
      super._switchStateValue = value;
    });
  }

  final _$checkPermissionStatusAsyncAction =
      AsyncAction('_SwitchStore.checkPermissionStatus');

  @override
  Future<void> checkPermissionStatus() {
    return _$checkPermissionStatusAsyncAction
        .run(() => super.checkPermissionStatus());
  }

  final _$getPermissionStateAsyncAction =
      AsyncAction('_SwitchStore.getPermissionState');

  @override
  Future<PermissionStatus?> getPermissionState(bool newState) {
    return _$getPermissionStateAsyncAction
        .run(() => super.getPermissionState(newState));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
