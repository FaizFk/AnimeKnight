import 'package:flutter/material.dart';
import '../models/animeDB_model.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

class AnimeInfo extends StatelessWidget {
  Anime anime;

  AnimeInfo(this.anime);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network('${anime.bigImageURL}'),
                SizedBox(
                  height: 18,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '${anime.title}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            color: Colors.red[900]),
                      ),
                    ),
                    Text(
                      '${anime.rating}',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.yellow),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '${anime.synopsis}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text('Trailer:'),
                    TextButton(
                        onPressed: () {
                          if (anime.trailerLink != null)
                            ul.launchUrl(Uri.parse('${anime.trailerLink}'));
                        },
                        child: Expanded(
                          child: Text(
                            anime.trailerLink == null
                                ? '***Cant find Trailer***'
                                : '${anime.trailerLink}',
                            style: TextStyle(
                                color: anime.trailerLink == null
                                    ? Colors.white
                                    : Colors.blue),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
