class BaseUrl {
  static const String apiKey = '126ebb02e23df3aeea5c466d49e6fd10';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  // static const String imageUrl = 'http://image.tmdb.org/t/p/original';
  String trendingUrl = '$baseUrl/trending/movie/day?api_key=$apiKey';
  String popularUrl = '$baseUrl/movie/popular?api_key=$apiKey';
  String genresUrl = '$baseUrl/genre/movie/list?api_key=$apiKey';
  String latestUrl = '$baseUrl/movie/latest?api_key=$apiKey';
  // String castUrl = '$baseUrl/movie/id/credits?api_key=$apiKey';
}
