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
  element.forEach((e) {
    final title = e.text;
    switch (title) {
      case '邀请':
        user.invitaion = e.nextElementSibling.text;
        break;
      case '邀请人':
        user.inviter = e.nextElementSibling.text;
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

  return user;
}
