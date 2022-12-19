import 'package:flutter/material.dart';
import 'package:movie_previewer/core/models/similar_movies_model.dart';
import 'package:movie_previewer/widgets/model_cards/similar_movies_card.dart';

class DisplaySimilarCard extends StatefulWidget {
  const DisplaySimilarCard({Key? key, required this.similarModel})
      : super(key: key);
  final Future<SimilarMoviesModel> similarModel;

  @override
  State<DisplaySimilarCard> createState() => _DisplaySimilarCardState();
}

class _DisplaySimilarCardState extends State<DisplaySimilarCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: FutureBuilder(
          future: widget.similarModel,
          builder: (_, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center();
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return const Center();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Unable to fetch similar movies, please refresh',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.results == null) {
                    return const Center(
                      child: Text('Oops! an error occured 🥴'),
                    );
                  } else {
                    return SimilarMoviesCard(similarMovieData: snapshot.data!);
                  }
                } else {
                  return const Text('No Internet Connection');
                }
            }
          }),
    );
  }
}
