import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_previewer/core/api_service.dart';
import 'package:movie_previewer/core/models/latest_model.dart';
import 'package:movie_previewer/core/models/trending_model.dart';
import 'package:movie_previewer/widgets/display_cards/display_latest_movie.dart';

import '../core/models/popular_model.dart';
import '../widgets/display_cards/display_popular_card.dart';
import '../widgets/display_cards/display_trending_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<TrendingModel> _trendingModel;
  late Future<PopularModel> popularModel;
  late Future<LatestModel> latestModel;
  @override
  void initState() {
    super.initState();
    _trendingModel = ApiService().trendingApi();
    popularModel = ApiService().popularApi();
    latestModel = ApiService().latestApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink,
        title:
            Text("Movie Parade", style: GoogleFonts.lobsterTwo(fontSize: 30)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              )),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Welcome. \nYour friendly movie preview app. \nExplore. Enjoy',
                  style: GoogleFonts.lobster(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 30,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('asset/bg/page_bg.png'),
              )),
              child: Text(
                'Trending Movies', 
                style: GoogleFonts.oleoScript(fontSize: 20, color: Colors.grey),
              ),
            ),
            DisplayTrendingMovies(trendingModel: _trendingModel),
            const SizedBox(height: 8),
            Text(
              'Popular Movies',
              style: GoogleFonts.oleoScript(fontSize: 20),
            ),
            DisplayPopularMovies(popularModel: popularModel),
            Text(
              'Latest Movies',
              style: GoogleFonts.oleoScript(fontSize: 20),
            ),
            DisplayLatestMovie(latestModel: latestModel)
          ],
        ),
      ),
    );
  }
}
