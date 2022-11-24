import 'package:movie_previewer/core/models/genres_model.dart';

import 'models/popular_model.dart';
import 'models/trending_model.dart';

abstract class BaseApi {
  Future<TrendingModel> trendingApi();
  Future<PopularModel> popularApi();
  Future<GenresModel> genresApi();
}
