import 'package:anime_knight/models/animeDB_model.dart' as AM;
import 'package:anime_knight/widgets/anime_card.dart';
import 'package:anime_knight/widgets/search_anime_card.dart';
import 'package:flutter/material.dart';
import '../models/animeDB_model.dart';

List<Anime> animeList = [];

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSpinning = false;
  @override
  void getList() async {
    setState(() {
      isSpinning = true;
    });

    animeList = await AM.createAnimeList(8);
    setState(() {
      isSpinning = false;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      getList();
    } catch (e) {
      print('errrrrrrrrrrrrrorrrrrrrr');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isSpinning
        ? Center(child: Text('Loading...'))
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(),
                        );
                      },
                      child: Row(
                        children: [
                          Text('Search '),
                          Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.red[900],
                          ),
                        ],
                      )),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    itemCount: animeList.length,
                    itemBuilder: (context, int i) {
                      return AnimeCard(anime: animeList[i]);
                    }),
              )
            ],
          ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<Anime> matchedAnimes = [];
    for (var anime in animeList) {
      if (anime.title!.toLowerCase().contains(query.toLowerCase()) &&
          query != '') {
        matchedAnimes.add(anime);
      }
    }
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: matchedAnimes.length,
        itemBuilder: (context, int i) {
          return SearchAnimeCard(anime: matchedAnimes[i]);
        });
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<Anime> matchedAnimes = [];
    for (var anime in animeList) {
      if (anime.title!.toLowerCase().contains(query.toLowerCase()) &&
          query != '') {
        matchedAnimes.add(anime);
      }
    }
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: matchedAnimes.length,
        itemBuilder: (context, int i) {
          return SearchAnimeCard(anime: matchedAnimes[i]);
        });
    throw UnimplementedError();
  }
}
