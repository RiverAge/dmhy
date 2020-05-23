part of 'torrent.dart';

/// 获取种子详情
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

  content.forEach((element) {
    setTorrent(element, torrent);
  });

  return torrent;
}

void setTorrent(Element el, Torrent torrent) {
  final header = el.querySelector('.rowhead').text.trim();
  switch (header) {
    case '副标题':
      torrent.subtitle = el.querySelector(".rowfollow").text.trim();
      break;
    case '基本信息':
      torrent.deployTime = el.querySelector("time").attributes['title'].trim();
      final info =
          el.querySelector(".rowfollow").text.split('\u00A0\u00A0\u00A0');
      info.forEach((e) {
        if (e.startsWith('大小:')) {
          torrent.size = e.substring(3).trim();
        } else if (e.startsWith('类型:')) {
          torrent.category = e.substring(3).trim();
        }
      });
      break;
    case '流量优惠':
      torrent.discount =
          (el.querySelector(".rowfollow img")?.attributes ?? {})["alt"];
      break;
    case '描述':
      // 描述
      torrent.cover =
          (el.querySelector("#kdescr bdo img")?.attributes ?? {})["src"]?.trim();
      torrent.references = List();
      el
          .querySelector("#kdescr bdo")
          ?.querySelectorAll("fieldset")
          ?.forEach((e) => torrent.references.add(e.text));
      break;
    case 'AniDB 信息':
      torrent.anidb =
          el.querySelector(".rowfollow a").attributes["href"].trim();
      break;
    case '种子信息':
      // 种子信息
      el.querySelectorAll(".no_border_wide").forEach((e) {
        if (e.text.startsWith('文件数')) {
          torrent.filesCount = e.text.replaceAll(
              new RegExp(r"\[查看列表\]\[隐藏列表\]\[全部展开\]\[全部关闭\]|文件数:\s"), '');
        } else if (e.text.startsWith('种子散列值')) {
          torrent.fileHash = e.text.replaceAll('种子散列值:', '');
        }
      });
      break;
    case '热度表':
      // 热度表
      el.querySelectorAll(".no_border_wide").forEach((e) {
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
      break;
    case '同伴[查看列表][隐藏列表]':
      final leecher = el.querySelector(".rowfollow #peercount");
      torrent.leechers = leecher.children[1].text.replaceAll('个下载者', '');
      torrent.seeders = leecher.firstChild.text.replaceAll('个做种者', '');
      break;
  }
}
