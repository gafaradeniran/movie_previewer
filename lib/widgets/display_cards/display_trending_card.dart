import 'package:flutter/material.dart';
import 'package:movie_previewer/widgets/model_cards/trending_card.dart';
import '../../core/models/trending_model.dart';

class DisplayTrendingMovies extends StatelessWidget {
  const DisplayTrendingMovies({
      Key? key, required Future<TrendingModel> trendingModel})
      : _trendingModel = trendingModel,
        super(key: key);

  final Future<TrendingModel> _trendingModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: FutureBuilder<TrendingModel>(
          future: _trendingModel,
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
                    return TrendingCard(data: snapshot.data!);
                  }
                } else {
                  return const Text('No Internet Connection');
                }
            }
          })),
    );
  }
}
