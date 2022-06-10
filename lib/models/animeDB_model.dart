import 'dart:convert';
import 'package:http/http.dart' as http;

class Anime {
  final String? bigImageURL;
  final String? smallImageURL;
  final String? title;
  final double? rating;
  final String? synopsis;

  Anime(
      {this.smallImageURL,
      this.bigImageURL,
      this.title,
      this.rating,
      this.synopsis});
}

Future<List<Anime>> createAnimeList(int pagenumber) async {
  List<Anime> animeList = [];
  for (int j = 0; j < pagenumber; j++) {
    var data;
    try {
      var res = await http.get(
          Uri.parse('https://api.jikan.moe/v4/top/anime?page=$pagenumber'));
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
        );
        animeList.add(anime);
      }
    }
  }
  return animeList;
}
