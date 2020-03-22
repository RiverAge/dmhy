part of 'torrent.dart';

Future<List<Torrent>> queryTorrent({@required cookie, String query}) async {
  final response = await http.get(
      'https://u2.dmhy.org/torrents.php?cat9=1&cat12=1&incldead=1&spstate=0&inclbookmarked=0&search=$query&search_area=0&search_mode=0',
      headers: {'cookie': cookie});

  if (response.statusCode != 200) {
    throw Exception(response.toString());
  }

  final document = parse(response.bodyBytes);
  final elements = document.querySelectorAll(".torrents > tbody > tr");
  List<Torrent> torrents = [];

  if (elements.length <= 1) {
    return [];
  }

  for (int i = 1; i < elements.length; i++) {
    final torrent = Torrent();
    torrent.category = elements[i].children[0].text;
    final title = elements[i].querySelector("a.tooltip[href^='details']");
    torrent.title = title?.text?.trim() ?? '';
    torrent.id = title?.attributes['href'].split("details.php?")[1].split('&')[0].split('=')[1] ?? '';

    torrent.isHot = elements[i].querySelector(".hot") != null;
    torrent.discount = (elements[i].querySelector("img[src='pic/trans.gif']")?.attributes ?? {})['alt'] ?? '';
    torrent.subtitle = elements[i].querySelector("span.tooltip")?.text?.trim() ?? '';
    torrent.discountRemain = elements[i].querySelector("time")?.text ?? '';

    torrent.comments = elements[i].children[2].text;
    torrent.ttl = elements[i].children[3].text;
    torrent.size = elements[i].children[4].text;
    torrent.seeders = elements[i].children[5].text;
    torrent.leechers = elements[i].children[6].text;
    torrent.completions = elements[i].children[7].text;

    torrents.add(torrent);
  }

  return torrents;
}
