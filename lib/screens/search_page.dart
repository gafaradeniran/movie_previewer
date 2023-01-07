import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_previewer/constants/style.dart';
import 'package:movie_previewer/core/api_service.dart';
import 'package:movie_previewer/screens/details_page.dart';

class SearchPage extends SearchDelegate {
  ApiService apiService = ApiService();
  String imageUrl = 'http://image.tmdb.org/t/p/original';
 

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (() {
          query = '';
        }),
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: apiService.searchApi(query),
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
                    'Unable to fetch query results',
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
                  return ListView.builder(
                    itemCount: snapshot.data?.results?.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailsPage(
                                        posterImg:
                                            '$imageUrl${snapshot.data?.results![index].posterPath}',
                                        releaseDate: snapshot
                                            .data?.results![index].releaseDate,
                                        originalLang: snapshot.data
                                            ?.results![index].originalLanguage,
                                        adult: snapshot
                                            .data?.results![index].adult,
                                        overview: snapshot
                                            .data?.results![index].overview,
                                        originalTitle: snapshot.data
                                            ?.results![index].originalTitle,
                                        id: snapshot.data?.results![index].id,
                                      )));
                        }),
                        child: ListTile(
                          leading: Image.network(
                              '$imageUrl${snapshot.data!.results![index].posterPath}'),
                          title: Text(
                            '${snapshot.data!.results![index].originalTitle}',
                            style: searchTitle,
                          ),
                          subtitle: Text(
                            '${snapshot.data!.results![index].overview}',
                            style: GoogleFonts.poppins(),
                            softWrap: true,
                            maxLines: 3,
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.navigate_next,
                                size: 35,
                              )),
                        ),
                      );
                    }),
                  );
                }
              } else {
                return const Text('No Internet Connection');
              }
          }
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('search movies by title'),
    );
  }
}
