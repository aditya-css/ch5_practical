// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SwitchStore on _SwitchStore, Store {
  final _$_locationSwitchStateAtom =
      Atom(name: '_SwitchStore._locationSwitchState');

  bool get locationSwitchState {
    _$_locationSwitchStateAtom.reportRead();
    return super._locationSwitchState;
  }

  @override
  bool get _locationSwitchState => locationSwitchState;

  @override
  set _locationSwitchState(bool value) {
    _$_locationSwitchStateAtom.reportWrite(value, super._locationSwitchState,
        () {
      super._locationSwitchState = value;
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
