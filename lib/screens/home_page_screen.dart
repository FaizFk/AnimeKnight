import 'package:anime_knight/models/animeDB_model.dart' as AM;
import 'package:anime_knight/widgets/anime_card.dart';
import 'package:flutter/material.dart';

import '../models/animeDB_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Anime> animeList = [];
  bool isSpinning = false;
  @override
  void getList() async {
    setState(() {
      isSpinning = true;
    });

    animeList = await AM.createAnimeList(4);
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
        ? Text('Loading...')
        : Column(
            children: [
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
