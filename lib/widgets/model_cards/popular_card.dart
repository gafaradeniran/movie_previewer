import 'package:flutter/material.dart';
import 'package:movie_previewer/core/models/popular_model.dart';
import 'package:movie_previewer/screens/details_page.dart';

class PopularCard extends StatefulWidget {
  const PopularCard({super.key, required this.data});
  final PopularModel data;
  @override
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  String imageUrl = 'http://image.tmdb.org/t/p/original';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.results!.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DetailsPage(
                          posterImg:
                              '$imageUrl${widget.data.results![index].posterPath}',
                          releaseDate: widget.data.results![index].releaseDate,
                          originalLang:
                              widget.data.results![index].originalLanguage,
                          adult: widget.data.results![index].adult,
                          overview: widget.data.results![index].overview,
                          originalTitle:
                              widget.data.results![index].originalTitle,
                          id: widget.data.results![index].id,
                        )));
          },
          child: SizedBox(
            height: 300,
            width: 220,
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.network(
                    '$imageUrl${widget.data.results![index].posterPath}',
                    height: 240,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                  // Text(
                  //   'Released ${widget.data.results![index].releaseDate}',
                  //   style: GoogleFonts.heebo(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white38),
                  //   softWrap: true,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
