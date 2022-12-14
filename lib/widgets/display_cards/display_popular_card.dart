import 'package:flutter/material.dart';
import 'package:movie_previewer/widgets/model_cards/popular_card.dart';
import '../../core/models/popular_model.dart';

class DisplayPopularMovies extends StatelessWidget {
  const DisplayPopularMovies({super.key, required this.popularModel});

  final Future<PopularModel> popularModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: FutureBuilder<PopularModel>(
          future: popularModel,
          builder: ((context, snapshot) {
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
                      'Unable to retrieve data, please refresh',
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
                    return PopularCard(data: snapshot.data!);
                  }
                } else {
                  return const Text('No Internet Connection');
                }
            }
          })),
    );
  }
}
