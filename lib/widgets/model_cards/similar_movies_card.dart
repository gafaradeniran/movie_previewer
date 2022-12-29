import 'package:flutter/material.dart';
import 'package:movie_previewer/core/models/similar_movies_model.dart';

class SimilarMoviesCard extends StatefulWidget {
  const SimilarMoviesCard({super.key, required this.similarMovieData});
  final SimilarMoviesModel similarMovieData;
  @override
  State<SimilarMoviesCard> createState() => _SimilarMoviesCardState();
}

class _SimilarMoviesCardState extends State<SimilarMoviesCard> {
  String imageUrl = 'http://image.tmdb.org/t/p/original';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.similarMovieData.results!.length,
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      '$imageUrl${widget.similarMovieData.results![index].posterPath}'),
                ),
                borderRadius: BorderRadius.circular(15)),
          );
        });
  }
}
