import 'dart:io';

import 'package:anime_knight/models/animeDB_model.dart' as AM;
import 'package:anime_knight/widgets/anime_card.dart';
import 'package:anime_knight/widgets/search_anime_card.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../models/animeDB_model.dart';

List<Anime> animeList = [];
List<Anime> animeSearchList = [];
bool isSpinning = false;
bool isSearching = false;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void getList() async {
    setState(() {
      isSpinning = true;
    });

    animeList = await AM.createAnimeList(3);
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
    return Stack(
      children: [
        (isSpinning
            ? Center(child: Text('Loading...'))
            : ListView.builder(
                padding: EdgeInsets.only(left: 5, right: 5, top: 55),
                itemCount: animeList.length,
                itemBuilder: (context, int i) {
                  return AnimeCard(anime: animeList[i]);
                })),
        isSpinning ? Container() : FSB()
      ],
    );
  }
}

class FSB extends StatefulWidget {
  const FSB({
    Key? key,
  }) : super(key: key);

  @override
  State<FSB> createState() => _FSBState();
}

class _FSBState extends State<FSB> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Enter atleast 3 letters...',
      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onSubmitted: (query) async {
        // Call your model, bloc, controller here.
        if (query == '') return;
        setState(() {
          isSearching = true;
        });
        animeSearchList = await AM.createAnimeSearchList(query);
        setState(() {
          isSearching = false;
        });
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return isSearching
            ? Container(
                height: 40,
                color: Colors.black,
                alignment: Alignment.center,
                child: Text('Loading'))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: animeSearchList.length,
                itemBuilder: (context, i) {
                  return SearchAnimeCard(anime: animeSearchList[i]);
                });
      },
    );
  }
}
