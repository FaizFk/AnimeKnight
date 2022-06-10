import 'package:anime_knight/models/animeDB_model.dart';
import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  AnimeCard({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 4),
            color: Color(0xFF241571),
            borderRadius: BorderRadius.circular(10)),
        height: 200,
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${anime.rating}',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.yellow,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
