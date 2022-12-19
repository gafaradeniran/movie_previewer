import 'package:flutter/material.dart';
import 'package:movie_previewer/core/models/latest_model.dart';
import 'package:movie_previewer/widgets/model_cards/latest_card.dart';

class DisplayLatestMovie extends StatelessWidget {
  const DisplayLatestMovie({super.key, required this.latestModel});
  final Future<LatestModel> latestModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FutureBuilder<LatestModel>(
          future: latestModel,
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
                  if (snapshot.data!.posterPath == null) {
                    return const Center(
                      child: Text('Oops! an error occured 🥴'),
                    );
                  } else {
                    return LatestCard(data: snapshot.data!);
                  }
                } else {
                  return const Text('No Internet Connection');
                }
            }
          })),
    );
  }
}
