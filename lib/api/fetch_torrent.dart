part of 'torrent.dart';

Future<Torrent> fetchTorrent({@required cookie, @required tid}) async {
  final response = await http.get('https://u2.dmhy.org/details.php?id=$tid&hit=1', headers: {
    'cookie': cookie
  });

  if (response.statusCode != 200) {
    throw Exception(response.toString());
  }

  final document = parse(response.bodyBytes);

  print(document);

  return Torrent();

}