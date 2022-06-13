import 'dart:convert';
import 'package:http/http.dart' as http;

class Anime {
  final String? bigImageURL;
  final String? smallImageURL;
  final String? title;
  final double? rating;
  final String? synopsis;
  final String? trailerLink;

  Anime(
      {this.smallImageURL,
      this.bigImageURL,
      this.title,
      this.rating,
      this.synopsis,
      this.trailerLink});
}

Future<List<Anime>> createAnimeList(int pagenumber) async {
  List<Anime> animeList = [];
  for (int j = 1; j <= pagenumber; j++) {
    var data;
    try {
      var res = await http
          .get(Uri.parse('https://api.jikan.moe/v4/top/anime?page=$j'));
      data = jsonDecode(res.body)['data'];
    } catch (e) {
      print(e);
    }

    if (data != null) {
      for (int i = 0; i < 25; i++) {
        Anime anime = Anime(
            smallImageURL: data[i]['images']['jpg']['image_url'],
            bigImageURL: data[i]['images']['jpg']['large_image_url'] == null
                ? data[i]['images']['jpg']['image_url']
                : data[i]['images']['jpg']['large_image_url'],
            title: data[i]['title'],
            rating: data[i]['score'],
            synopsis: data[i]['synopsis'],
            trailerLink: data[i]['trailer']['url']);
        animeList.add(anime);
      }
    }
  }
  return animeList;
}

Future<List<Anime>> createAnimeSearchList(String query) async {
  List<Anime> animeSearchList = [];
  if (query.length > 3) {
    List? data;
    var animeData;
    try {
      var res = await http.get(
          Uri.parse('https://api.jikan.moe/v3/search/anime?q=$query&page=1'));
      data = jsonDecode(res.body)['results'];
    } catch (e) {
      print(e);
    }

    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        int malID = data[i]['mal_id'];
        try {
          var res2 = await http
              .get(Uri.parse('https://api.jikan.moe/v4/anime/$malID/full'));
          animeData = jsonDecode(res2.body)['data'];
        } catch (e) {
          print(e);
        }
        if (animeData != null) {
          Anime anime = Anime(
            smallImageURL: animeData['images']['jpg']['image_url'],
            bigImageURL: animeData['images']['jpg']['large_image_url'] == null
                ? animeData['images']['jpg']['image_url']
                : animeData['images']['jpg']['large_image_url'],
            title: animeData['title'],
            rating: animeData['score'],
            synopsis: animeData['synopsis'],
            trailerLink: animeData['trailer']['url'],
          );
          animeSearchList.add(anime);
        }
      }
    }
  }
  return animeSearchList;
}
