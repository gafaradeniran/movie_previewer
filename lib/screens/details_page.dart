import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_previewer/constants/style.dart';
import 'package:movie_previewer/core/api_service.dart';
import 'package:movie_previewer/core/models/cast_model.dart';
import 'package:movie_previewer/core/models/similar_movies_model.dart';
import 'package:movie_previewer/widgets/display_cards/display_cast_card.dart';
import 'package:movie_previewer/widgets/display_cards/display_similar_card.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key,
      this.posterImg,
      this.releaseDate,
      this.originalLang,
      this.adult,
      this.overview,
      this.id,
      this.originalTitle})
      : super(key: key);
  final String? posterImg, overview, originalLang, originalTitle;
  final bool? adult;
  final int? id;
  final DateTime? releaseDate;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<CastModel> castModel;
  late Future<SimilarMoviesModel> similarModel;
  int? id;
  @override
  void initState() {
    castModel = ApiService().castApi(widget.id!);
    similarModel = ApiService().similarMoviesApi(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text(
          'Movie Details',
          style: GoogleFonts.poppins(fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.posterImg!,
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            widget.originalTitle!,
                            style: titleFont,
                            softWrap: true,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Language: ${widget.originalLang!}',
                            style: detailsFont,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Released: ${widget.releaseDate!}',
                            style: detailsFont,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Adult: ${widget.adult!}',
                            style: detailsFont,
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview',
                      style: detailsHeader,
                    ),
                    Text(widget.overview!, style: detailsBody, softWrap: true),
                    // Text(widget.overview),
                    Text(
                      'Casts',
                      style: detailsHeader,
                    ),

                    DisplayCastCard(castModel: castModel),

                    Text(
                      'Similar Movies',
                      style: detailsHeader,
                    ),
                    DisplaySimilarCard(similarModel: similarModel)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
