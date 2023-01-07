import 'package:movie_previewer/core/models/cast_model.dart';
import 'package:movie_previewer/core/models/genres_model.dart';
import 'package:movie_previewer/core/models/latest_model.dart';
import 'package:movie_previewer/core/models/search_model.dart';
import 'package:movie_previewer/core/models/similar_movies_model.dart';
import 'package:movie_previewer/core/models/video_model.dart';

import 'models/popular_model.dart';
import 'models/trending_model.dart';

abstract class BaseApi {
  Future<TrendingModel> trendingApi();
  Future<PopularModel> popularApi();
  Future<GenresModel> genresApi();
  Future<LatestModel> latestApi();
  Future<CastModel> castApi(int id);
  Future<SimilarMoviesModel> similarMoviesApi(int movieId);
  Future<SearchModel> searchApi(String? query);
  Future<VideoModel> videoApi(int movieId);
}
