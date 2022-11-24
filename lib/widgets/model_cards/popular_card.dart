import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_previewer/core/models/popular_model.dart';

class PopularCard extends StatefulWidget {
  const PopularCard({super.key, required this.data});
  final PopularModel data;
  @override
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  String imageUrl = 'https://image.tmdb.org/t/p/original';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.results!.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 300,
          width: 220,
          child: Card(
            margin: const EdgeInsets.all(10),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child:
                Column(
                  children: [
                    Image.network(
                      '$imageUrl${widget.data.results![index].backdropPath}',
                      height: 250,
                      width: 220,
                      fit: BoxFit.cover,
                    ),
                    Text(
              'Released ${widget.data.results![index].releaseDate}',
              style: GoogleFonts.heebo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
                  ],
                ),
                
          ),
        );
      },
    );
  }
}
