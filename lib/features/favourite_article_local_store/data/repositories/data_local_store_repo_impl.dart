import 'dart:typed_data';

import 'package:ch5_practical/core/db_const.dart';
import 'package:ch5_practical/core/extensions.dart';
import 'package:ch5_practical/core/result_state_template.dart';
import 'package:ch5_practical/features/favourite_article_local_store/data/data_source/local_database_provider.dart';
import 'package:ch5_practical/features/favourite_article_local_store/domain/repositories/data_local_store_repository.dart';
import 'package:ch5_practical/features/home_article_fetch/data/models/article_api_model.dart';
import 'package:ch5_practical/features/home_article_fetch/domain/entities/article_entity.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class DataLocalStoreRepositoryImpl implements DataLocalStoreRepository {
  final LocalDatabaseProvider _databaseProvider;

  DataLocalStoreRepositoryImpl(this._databaseProvider);

  @override
  Future<ResultState> deleteAllFavourites() async {
    try {
      final Database _db = await _databaseProvider.dBase;
      int _result = await _db.delete(DBConst.tableName);
      return Success<int>(_result);
    } catch (e) {
      return Failure(
        ApiException(
          message: PrintMyException(e.toString()).message,
        ),
      );
    }
  }

  @override
  Future<ResultState> getAllFavourites() async {
    try {
      final Database _db = await _databaseProvider.dBase;
      List<Map<String, Object?>> _result = await _db.query(DBConst.tableName);
      if (_result.isEmpty) {
        throw Exception('Go Ahead and Favourite any Article that you like.');
      }
      List<Article> _favouriteArticles =
          _result.map((article) => ArticleApiModel.fromJson(article)).toList();
      return Success<List<Article>>(_favouriteArticles);
    } catch (e) {
      return Failure(
        ApiException(
          message: PrintMyException(e.toString()).message,
        ),
      );
    }
  }

  @override
  Future<ResultState> removeFavourite(int id) async {
    try {
      final Database _db = await _databaseProvider.dBase;
      int _result = await _db.delete(
        DBConst.tableName,
        where: '${DBConst.colId} = ?',
        whereArgs: [id],
      );
      if (_result <= 0) {
        throw Exception('No data found to be deleted.');
      }
      return Success<int>(_result);
    } catch (e) {
      return Failure(
        ApiException(
          message: PrintMyException(e.toString()).message,
        ),
      );
    }
  }

  @override
  Future<ResultState> saveFavourite(Article favouriteArticle) async {
    try {
      ResultState _isAlreadySaved = await findFavourite(favouriteArticle.title);
      if (!(_isAlreadySaved as Success<num>).value.isNaN) {
        throw Exception('The Article is Already Marked as Favourite.');
      }
      ArticleApiModel? _articleForDB;
      if (favouriteArticle.urlToImage != null) {
        Uint8List? _responseImgBytes;
        try {
          final Response<Uint8List> _imgResponse = await Dio().get<Uint8List>(
            favouriteArticle.urlToImage!,
            options: Options(responseType: ResponseType.bytes),
          );
          _responseImgBytes = _imgResponse.data!;
        } catch (e) {
          _responseImgBytes = null;
        }

        _articleForDB = ArticleApiModel(
          aid: favouriteArticle.id,
          writer: favouriteArticle.author,
          body: favouriteArticle.content,
          desc: favouriteArticle.description,
          date: favouriteArticle.publishedAt,
          src: {'name': favouriteArticle.source},
          heading: favouriteArticle.title,
          imgUrl: favouriteArticle.urlToImage,
          imgBinary: _responseImgBytes,
        );
      }
      final Database _db = await _databaseProvider.dBase;
      int result = await _db.insert(
        DBConst.tableName,
        ((_articleForDB ?? favouriteArticle) as ArticleApiModel).toDBJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Success<int>(result);
    } catch (e) {
      return Failure(
        ApiException(
          message: PrintMyException(e.toString()).message,
        ),
      );
    }
  }

  @override
  Future<ResultState> findFavourite(String articleTitle) async {
    try {
      final Database _db = await _databaseProvider.dBase;
      List<Map<String, Object?>> _result = await _db.query(
        DBConst.tableName,
        where: '${DBConst.colTitle} = ?',
        whereArgs: [articleTitle],
      );
      final num _articleFindResult =
          _result.isEmpty ? double.nan : _result.first['id'] as int;
      return Success<num>(_articleFindResult);
    } catch (e) {
      return Failure(
        ApiException(
          message: PrintMyException(e.toString()).message,
        ),
      );
    }
  }
}
