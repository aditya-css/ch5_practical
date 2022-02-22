import 'package:ch5_practical/core/db_const.dart';
import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/data/data_source/local_database_provider.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';
import 'package:ch5_practical/features/home_article_fetch/data/models/article_api_model.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DataLocalStoreRepositoryImpl implements DataLocalStoreRepository {
  final LocalDatabaseProvider _databaseProvider;

  DataLocalStoreRepositoryImpl(this._databaseProvider);

  @override
  Future<ResultState> deleteAllFavourites() async {
    try {
      final Database db = await _databaseProvider.dBase;
      int result = await db.delete(DBConst.tableName);
      return Success<int>(result);
    } catch (e) {
      return Failure(
        ApiException(message: e.toString().split(':')[1]),
      );
    }
  }

  @override
  Future<ResultState> getAllFavourites() async {
    try {
      final Database db = await _databaseProvider.dBase;
      List<Map<String, Object?>> result = await db.query(DBConst.tableName);
      result.map((e) => debugPrint(e.toString()));
      if (result.isEmpty) {
        throw Exception('Go Ahead and Favourite any Article that you like.');
      }
      List<Article> favArticles =
          result.map((news) => ArticleApiModel.fromJson(news)).toList();
      return Success<List<Article>>(favArticles);
    } catch (e) {
      return Failure(
        ApiException(message: e.toString().split(':')[1]),
      );
    }
  }

  @override
  Future<ResultState> removeFavourite(int id) async {
    try {
      final Database db = await _databaseProvider.dBase;
      int result = await db.delete(
        DBConst.tableName,
        where: '${DBConst.colId} = ?',
        whereArgs: [id],
      );
      if (result <= 0) {
        throw Exception('No data found to be deleted.');
      }
      return Success<int>(result);
    } catch (e) {
      return Failure(
        ApiException(message: e.toString().split(':')[1]),
      );
    }
  }

  @override
  Future<ResultState> saveFavourite(Article favArticle) async {
    try {
      final Database db = await _databaseProvider.dBase;
      ResultState _alreadySaved = await isFavourite(favArticle.title);
      if (!(_alreadySaved as Success<num>).value.isNaN) {
        throw Exception('The Article is Already Marked as Favourite.');
      }
      int result = await db.insert(
        DBConst.tableName,
        (favArticle as ArticleApiModel).toDBJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Success<int>(result);
    } catch (e) {
      return Failure(
        ApiException(message: e.toString().split(':')[1]),
      );
    }
  }

  @override
  Future<ResultState> isFavourite(String articleTitle) async {
    try {
      final Database db = await _databaseProvider.dBase;
      List<Map<String, Object?>> result = await db.query(
        DBConst.tableName,
        where: '${DBConst.colTitle} = ?',
        whereArgs: [articleTitle],
      );
      num ans = result.isEmpty ? double.nan : result.first['id'] as int;
      return Success<num>(ans);
    } catch (e) {
      return Failure(
        ApiException(message: e.toString().split(':')[1]),
      );
    }
  }
}
