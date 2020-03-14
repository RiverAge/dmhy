part of 'user.dart';
Future<List<Torrent>> fetchSeedings(String cookie, String uid) async {
  final response = await http.get('https://u2.dmhy.org/getusertorrentlistajax.php?userid=$uid&type=seeding',
      headers: {'cookie': cookie});

  if (response.statusCode != 200) {
    throw Exception(response.toString());
  }

  final document = parse(response.bodyBytes);

  final elements = document.querySelectorAll("body > table > tbody > tr");
  final List<Torrent> torrents = [];

  // elements.forEach((element) { 
  //   print(element);
  // });

  for (int i = 1; i < elements.length; i++) {
    final element = elements[i];
    final torrent = Torrent();
    torrent.category = element.firstChild.text;
    torrent.title = element.children[1].children[0].children[0].children[0].text.trim();
    torrent.subtitle = element.children[1].children[0].children[0].children[1].text.trim();
    torrent.discount = element.children[1].children[0].children[0].children[1].children[0].children[0].attributes["alt"] ?? '';
  
    torrent.id = element.children[1].children[0].children[0].children[0].children[0].children[0].attributes['href'].split("details.php?")[1].split('&')[0].split('=')[1];
    torrent.size = element.children[2].text;
    torrent.seeders = element.children[3].text;
    torrent.leechers = element.children[4].text;
    torrent.uploadSize = element.children[6].text;
    torrent.downloadSize = element.children[7].text;
    torrent.ratio = element.children[8].text;

    torrents.add(torrent);
  }

  return torrents;
}
