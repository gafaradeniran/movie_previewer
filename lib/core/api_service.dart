import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:movie_previewer/core/base_api.dart';
import 'package:movie_previewer/core/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:movie_previewer/core/models/cast_model.dart';
import 'package:movie_previewer/core/models/genres_model.dart';
import 'package:movie_previewer/core/models/latest_model.dart';
import 'package:movie_previewer/core/models/search_model.dart';
import 'package:movie_previewer/core/models/similar_movies_model.dart';
import 'package:movie_previewer/core/models/trending_model.dart';
import 'package:movie_previewer/core/models/popular_model.dart';
import 'package:movie_previewer/core/models/video_model.dart';

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
      return TrendingModel(results: res["results"]);
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
      return PopularModel(results: res["results"]);
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

  @override
  Future<LatestModel> latestApi() async {
    try {
      final response = await http.get(Uri.parse(url.latestUrl));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        LatestModel latestModel = latestModelFromJson(response.body);
        return LatestModel(
            originalTitle: latestModel.originalTitle,
            backdropPath: latestModel.backdropPath,
            posterPath: latestModel.posterPath,
            genres: latestModel.genres,
            releaseDate: latestModel.releaseDate,
            status: latestModel.status);
      }
      return LatestModel(
          posterPath: res["posterPath"], originalTitle: res["originalTitle"]);
    } on SocketException catch (_) {
      return LatestModel(status: 'No internet connection');
    } on TimeoutException catch (_) {
      return LatestModel(status: 'Time out');
    } catch (e) {
      return LatestModel(status: e.toString());
    }
  }

//movie casts
  @override
  Future<CastModel> castApi(id) async {
    String castUrl =
        'http://api.themoviedb.org/3/movie/$id/credits?api_key=126ebb02e23df3aeea5c466d49e6fd10';

    try {
      final response = await http.get(Uri.parse(castUrl));

      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CastModel castModel = castModelFromJson(response.body);

        return CastModel(cast: castModel.cast, id: castModel.id);
      }
      return CastModel(cast: res['cast'], id: res['id']);
    } on SocketException catch (_) {
      return CastModel();
    } on TimeoutException catch (_) {
      return CastModel();
    } catch (e) {
      return CastModel();
    }
  }

  @override
  Future<SimilarMoviesModel> similarMoviesApi(int movieId) async {
    String similarUrl =
        'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=126ebb02e23df3aeea5c466d49e6fd10';

    try {
      final response = await http.get(Uri.parse(similarUrl));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SimilarMoviesModel similarMoviesModel =
            similarMoviesModelFromJson(response.body);
        return SimilarMoviesModel(results: similarMoviesModel.results);
      }
      return SimilarMoviesModel(results: res['results']);
    } catch (e) {
      return SimilarMoviesModel();
    }
  }

  @override
  Future<SearchModel> searchApi(String? query) async {
    String searchUrl =
        'https://api.themoviedb.org/3/search/movie?api_key=126ebb02e23df3aeea5c466d49e6fd10&query=$query&page=1';

    try {
      final response = await http.get(Uri.parse(searchUrl));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SearchModel searchModel = searchModelFromJson(response.body);
        return SearchModel(results: searchModel.results);
      }
      return SearchModel(results: res['results']);
    } catch (ex) {
      return SearchModel();
    }
  }

  @override
  Future<VideoModel> videoApi(int? movieId) async {
    String videoUrl =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=126ebb02e23df3aeea5c466d49e6fd10';

    try {
      final response = await http.get(Uri.parse(videoUrl));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        VideoModel videoModel = videoModelFromJson(response.body);
        return VideoModel(results: videoModel.results);
      }
      return VideoModel(results: res['results'], id: res['id']);
    } catch (e) {
      throw UnimplementedError(e.toString());
    }
  }
}
