import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:movie_previewer/core/base_api.dart';
import 'package:movie_previewer/core/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:movie_previewer/core/models/genres_model.dart';
import 'package:movie_previewer/core/models/trending_model.dart';
import 'package:movie_previewer/core/models/popular_model.dart';

BaseUrl url = BaseUrl();

class ApiService extends BaseApi {
  @override
  Future<TrendingModel> trendingApi() async {
    try {
      final response = await http.get(Uri.parse(url.trendingUrl));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        TrendingModel trendingModel = trendingModelFromJson(response.body);
        return TrendingModel(
            results: trendingModel.results,
            totalPages: trendingModel.totalPages,
            page: trendingModel.page,
            totalResults: trendingModel.totalResults);
      }
      return TrendingModel(message: res["message"]);
    } on SocketException catch (_) {
      return TrendingModel(message: 'No internet connection');
    } on TimeoutException catch (_) {
      return TrendingModel(message: 'Time out');
    } catch (e) {
      return TrendingModel(message: e.toString());
    }
  }

  @override
  Future<PopularModel> popularApi() async {
    try {
      final response = await http.get(Uri.parse(url.popularUrl));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        PopularModel popularModel = popularModelFromJson(response.body);
        return PopularModel(
            results: popularModel.results,
            totalPages: popularModel.totalPages,
            page: popularModel.page,
            totalResults: popularModel.totalResults);
      }
      return PopularModel(message: res["message"]);
    } on SocketException catch (_) {
      return PopularModel(message: 'No internet connection');
    } on TimeoutException catch (_) {
      return PopularModel(message: 'Time out');
    } catch (e) {
      return PopularModel(message: e.toString());
    }
  }

  @override
  Future<GenresModel> genresApi() async {
    try {
      final response = await http.get(Uri.parse(url.genresUrl));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        GenresModel genresModel = genresModelFromJson(response.body);
        return GenresModel(
            message: genresModel.message, genres: genresModel.genres);
      }
      return GenresModel(message: res["message"]);
    } on SocketException catch (_) {
      return GenresModel(message: 'No internet connection');
    } on TimeoutException catch (_) {
      return GenresModel(message: 'Time out');
    } catch (e) {
      return GenresModel(message: e.toString());
    }
  }
  //movie casts
}
