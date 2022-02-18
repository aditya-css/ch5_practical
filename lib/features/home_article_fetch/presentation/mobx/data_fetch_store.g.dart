// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_fetch_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DataFetchStore on _DataFetchStore, Store {
  final _$_DataFetchStoreActionController =
      ActionController(name: '_DataFetchStore');

  @override
  ObservableFuture<ResultState<dynamic>> getArticles() {
    final _$actionInfo = _$_DataFetchStoreActionController.startAction(
        name: '_DataFetchStore.getArticles');
    try {
      return super.getArticles();
    } finally {
      _$_DataFetchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  ObservableFuture<ResultState<dynamic>> getCategories() {
    final _$actionInfo = _$_DataFetchStoreActionController.startAction(
        name: '_DataFetchStore.getCategories');
    try {
      return super.getCategories();
    } finally {
      _$_DataFetchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
