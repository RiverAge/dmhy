part of 'torrent.dart';

Future<Torrent> fetchTorrent({@required cookie, @required tid}) async {
  final response = await http.get(
      'https://u2.dmhy.org/details.php?id=$tid&hit=1',
      headers: {'cookie': cookie});

  if (response.statusCode != 200) {
    throw Exception(response.toString());
  }

  final document = parse(response.bodyBytes);

  final torrent = Torrent();

  torrent.title = document.querySelector("h1#top").text;
  torrent.id =
      document.querySelector("h3").text.replaceAll(new RegExp(r'\(|\)|#'), '');

  final content = document.querySelectorAll("h3 + table > tbody > tr");
  torrent.subtitle = content[1].querySelector(".rowfollow").text;

  torrent.deployTime = content[2].querySelector("time").attributes['title'];

  final info =
      content[2].querySelector(".rowfollow").text.split('\u00A0\u00A0\u00A0');
  info.forEach((e) {
    if (e.startsWith('大小:')) {
      torrent.size = e.substring(3);
    } else if (e.startsWith('类型:')) {
      torrent.category = e.substring(3);
    }
  });

  torrent.cover =
      (content[8].querySelector("#kdescr bdo img")?.attributes ?? {})["src"];
  torrent.references = List();
  content[8]
      .querySelector("#kdescr bdo")
      .querySelectorAll("fieldset")
      .forEach((e) => torrent.references.add(e.text));

  torrent.anidb = content[9].querySelector(".rowfollow a").attributes["href"];

  content[11].querySelectorAll(".no_border_wide").forEach((e) {
    if (e.text.startsWith('文件数')) {
      torrent.filesCount = e.text.replaceAll(
          new RegExp(r"\[查看列表\]\[隐藏列表\]\[全部展开\]\[全部关闭\]|文件数:\s"), '');
    } else if (e.text.startsWith('种子散列值')) {
      torrent.fileHash = e.text.replaceAll('种子散列值:', '');
    }
  });

  content[12].querySelectorAll(".no_border_wide").forEach((e) {
    if (e.text.startsWith('点击:')) {
      torrent.uv = e.text.replaceAll('点击:', '').trim();
    } else if (e.text.startsWith('查看')) {
      torrent.pv = e.text.replaceAll('查看:', '').trim();
    } else if (e.text.startsWith('完成')) {
      torrent.completions = e.text.replaceAll('完成:', '').trim();
    } else if (e.text.startsWith('最近活动')) {
      torrent.lastActivity = e.text.replaceAll('最近活动:', '').trim();
    }
  });

  print(torrent);

  return torrent;
}
