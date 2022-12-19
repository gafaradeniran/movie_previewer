import 'package:flutter/material.dart';
import 'package:movie_previewer/core/models/latest_model.dart';

class LatestCard extends StatefulWidget {
  const LatestCard({super.key, required this.data});
  final LatestModel data;

  @override
  State<LatestCard> createState() => _LatestCardState();
}

class _LatestCardState extends State<LatestCard> {
  String imageUrl = 'http://image.tmdb.org/t/p/original';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            height: 280,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      '$imageUrl${widget.data.posterPath}',
                    ))),
            // child: Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Text(
            //     'Released ${widget.data.releaseDate}',
            //     style: GoogleFonts.heebo(
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //     softWrap: true,
            //   ),
            // ),
          );
        }));
  }
}
