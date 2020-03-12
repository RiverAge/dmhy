import 'package:dmhy/model/user/user.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<User> fetchDetail(String cookie, String uid) async {
  final response = await http.get('https://u2.dmhy.org/userdetails.php?id=$uid',
      headers: {'cookie': cookie});

  if (response.statusCode != 200) {
    throw Exception(response.toString());
  }

  final document = parse(response.bodyBytes);

  final element = document.querySelectorAll('.rowhead');

  final user = User();

  user.userName = document.querySelector('#info_block bdo').text;

  element.forEach((e) {
    final title = e.text;
    switch (title) {
      case '性别':
        user.gender = e.nextElementSibling.firstChild.attributes["title"];
        break;
      case '头像':
        user.avatar = e.nextElementSibling.firstChild.attributes["src"];
        break;
      case '等级':
        user.level = e.nextElementSibling.firstChild.attributes["title"];
        break;
      case '邀请':
        user.invitaion = e.nextElementSibling.text;
        break;
      case '邀请人':
        user.inviter = e.nextElementSibling.text;
        break;
      case '网络带宽':
        final splitRet = e.nextElementSibling.text.replaceAll('\u00A0', ' ').split(' ').where((element) => element != '').toList();
        user.uploadSpeed = splitRet[1];
        user.downloadSpeed = splitRet[0];
        user.isp = splitRet[2];
        break;
      case '加入日期':
        user.joinDate = e.nextElementSibling.text;
        break;
      case '最近动向':
        user.recentTrends = e.nextElementSibling.text;
        break;
      case 'UCoin[详情]':
        user.ucoin = e.nextElementSibling.text;
        break;
      case '收到好人卡':
        user.friendZone = e.nextElementSibling.text;
        break;
      case '收到坏人卡':
        user.badGuyZone = e.nextElementSibling.text;
        break;
      case '经验值':
        user.experience = e.nextElementSibling.text;
        break;
    }
  });

  // 传输信息
  final tran = document.querySelectorAll('.embedded');
  tran.forEach((t) {
    final text = t.text;
    if (text.contains('分享率')) {
      user.ratio = t.text.split('分享率:')[1].trim();
    } else if (text.contains('上传量')) {
      user.upload = t.text.split('上传量:')[1].trim();
    } else if (text.contains('下载量')) {
      user.download = t.text.split('下载量:')[1].trim();
    } else if (text.contains('实际上传')) {
      user.actualUpload = t.text.split('实际上传:')[1].trim();
    } else if (text.contains('实际下载')) {
      user.actualDownload = t.text.split('实际下载:')[1].trim();
    } else if (text.contains('做种/下载时间比率')) {
      user.seedingDownloadRatio = t.text.split('做种/下载时间比率:')[1].trim();
    } else if (text.contains('做种时间')) {
      user.seedingTime = t.text.split('做种时间:')[1].trim();
    } else if (text.contains('下载时间')) {
      user.downloadTime = t.text.split('下载时间:')[1].trim();
    }
  });

  return user;
}
