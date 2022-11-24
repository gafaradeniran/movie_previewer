import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/models/trending_model.dart';

class TrendingCard extends StatefulWidget {
  const TrendingCard({super.key, required this.data});
  final TrendingModel data;
  @override
  State<TrendingCard> createState() => _TrendingCardState();
}

class _TrendingCardState extends State<TrendingCard> {
  String imageUrl = 'http://image.tmdb.org/t/p/original';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.results!.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            height: 300,
            width: 220,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        '$imageUrl${widget.data.results![index].posterPath}',
                        
                        ))),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Released ${widget.data.results![index].releaseDate}',
                style: GoogleFonts.heebo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                softWrap: true,
              ),
            ),
          );
        });
  }
}
