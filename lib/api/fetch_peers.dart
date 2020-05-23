part of 'torrent.dart';

Future<List<Peer>> fetchPeerByTorrent(
    {@required String cookie, String tid}) async {
  final response = await http.get(
      'https://u2.dmhy.org/viewpeerlist.php?id=$tid',
      headers: {'cookie': cookie});

  if (response.statusCode != 200) {
    throw Exception(response.toString());
  }

  final document = parse(response.bodyBytes);

  final tables = document.querySelectorAll("table.main-inner");

  final elements = tables[0].querySelectorAll("tbody > tr");

  List<Peer> result = [];

  elements.skip(1).forEach((element) {
    _setPeer(result, element, true);
  });

  if (tables.length > 1) {
    final downloadElements = tables[1].querySelectorAll("tbody > tr");

    downloadElements.skip(1).forEach((element) {
      _setPeer(result, element, false);
    });
  }

  return result;
}

_setPeer(List<Peer> result, Element element, bool isSeeder) {
  final row = element.querySelectorAll("td");
  final peer = Peer();

  peer.userName = row[0].text;
  peer.uploadSize = row[1].text;
  peer.averageUploadSpeed = row[2].text;
  peer.instantaneousUploadSpeed = row[3].text;
  peer.downloadSize = row[4].text;
  peer.averageDownloadSpeed = row[5].text;
  peer.ratio = row[6].text;
  peer.connectTime = row[7].text;
  peer.idleTime = row[8].text;
  peer.btClient = row[9].text;
  peer.isSeeder = true;

  result.add(peer);
}
