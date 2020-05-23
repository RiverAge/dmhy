part of 'torrent.dart';

Future<List<File>> fetchFilesByTorrent(
    {@required String cookie, String tid}) async {
  final response = await http.get(
      'https://u2.dmhy.org/viewfilelist.php?id=$tid',
      headers: {'cookie': cookie});

  if (response.statusCode != 200) {
    throw Exception(response.toString());
  }

  final document = parse(response.bodyBytes);

  final filesElement = document.querySelectorAll("table > tbody > tr");

  List<File> files = [];

  filesElement.skip(1).forEach((element) {
    final file = File();
    file.id = element.attributes["id"].split('_')[2];
    file.name = element.children[0].text;
    file.size = element.children[1].text;

    files.add(file);
  });


  return files;
}
