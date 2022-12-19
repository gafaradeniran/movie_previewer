import 'package:flutter/material.dart';
import 'package:movie_previewer/core/models/cast_model.dart';
import 'package:movie_previewer/widgets/model_cards/cast_card.dart';

class DisplayCastCard extends StatefulWidget {
  const DisplayCastCard({Key? key, required this.castModel}) : super(key: key);
  final Future<CastModel> castModel;

  @override
  State<DisplayCastCard> createState() => _DisplayCastCardState();
}

class _DisplayCastCardState extends State<DisplayCastCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: FutureBuilder(
          future: widget.castModel,
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
                      'Unable to casts data, please refresh',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.cast == null) {
                    return const Center(
                      child: Text('Oops! an error occured 🥴'),
                    );
                  } else {
                    return CastCard(snapshot: snapshot.data!);
                  }
                } else {
                  return const Text('No Internet Connection');
                }
            }
          })),
    );
  }
}
