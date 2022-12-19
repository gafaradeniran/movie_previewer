import 'package:flutter/material.dart';
import 'package:movie_previewer/constants/style.dart';
import 'package:movie_previewer/core/models/cast_model.dart';

class CastCard extends StatefulWidget {
  const CastCard( {Key? key, required this.snapshot}) : super(key: key);
  final CastModel snapshot;
 
  @override
  State<CastCard> createState() => _CastCardState();
}

class _CastCardState extends State<CastCard> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = 'http://image.tmdb.org/t/p/original';
    return ListView.builder(
        itemCount: widget.snapshot.cast!.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Image.network(
                    '$imageUrl${widget.snapshot.cast![index].profilePath}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain),
                Text('${widget.snapshot.cast![index].name}',
                    style: castName, softWrap: true),
              ],
            ),
          );
        });
  }
}
