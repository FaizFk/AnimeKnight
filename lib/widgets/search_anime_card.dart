import 'package:anime_knight/models/animeDB_model.dart';
import 'package:anime_knight/screens/anime_info_screen.dart';
import 'package:flutter/material.dart';

class SearchAnimeCard extends StatelessWidget {
  final Anime anime;

  SearchAnimeCard({required this.anime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AnimeInfo(anime)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              color: Color(0xFF008888),
              borderRadius: BorderRadius.circular(10)),
          height: 100,
          width: double.infinity,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Image.network(
                '${anime.smallImageURL}',
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      '${anime.title}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
