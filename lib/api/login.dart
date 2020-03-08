import 'dart:convert';
import 'dart:io';

import 'package:dmhy/exception/login.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

Future<String> fetchCookie() async {
  final response = await http.get('https://u2.dmhy.org/portalbc.php');
  if (response.statusCode == 200) {
    final cookie = response.headers["set-cookie"]
        .split(',')
        .map((e) => e.split(';'))
        .expand((element) => element)
        .toList()
        .where((element) =>
            element.startsWith('__cfduid=') || element.startsWith('PHPSESSID='))
        .join(';');

    return cookie;
  } else {
    throw Exception(response.statusCode);
  }
}

Future<String> login(
    {@required String username,
    @required String password,
    @required String captcha,
    @required String cookie,
    @required bool enableSSL,
    @required bool lockSessionIP}) async {
  final body = {
    'login_type': 'email',
    'login_ajax': '1',
    'username': username,
    'password': password,
    'captcha': captcha
  };

  if (enableSSL) {
    body['securelogin'] = 'yes';
  }

  if (lockSessionIP) {
    body['ssl'] = 'yes';
  }

  final response = await http.post('https://u2.dmhy.org/takelogin.php',
      headers: {
        'cookie': cookie,
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body);

  if (response.statusCode == 200) {
    final ret = json.decode(response.body) as Map<String, dynamic>;

    if (ret['status'] == 'error') {
      if ((ret['message'] as String).contains('Wrong CAPTCHA')) {
        throw WrongCaptchaException();
      } else {
        throw Exception(ret['message']);
      }
    } else if (ret['status'] == 'redirect') {
      final cookie = response.headers["set-cookie"]
          .split(',')
          .map((e) => e.split(';'))
          .expand((element) => element)
          .toList()
          .where((element) => element.startsWith('nexusphp_u2='))
          .join(';');
      return cookie;
    } else {
      throw Exception(ret.toString());
    }
  } else {
    throw Exception(response.statusCode);
  }
}

Future<String> getUid(String cookie) async {
  final response =  await http.get('https://u2.dmhy.org/', headers: {'cookie': cookie});
  if (response.statusCode == 200) {
    final document = parse(response.bodyBytes);
    final el = document.querySelector('#info_block a[href^="userdetails.php?"]');
    final herf = el.attributes['href'];
    final param = herf.substring(16);
    final ret = param.split('&').where((element) => element.startsWith('id=')).toList();
    if (ret != null && ret.length > 0) {
      return ret[0].substring(3);
    } else {
      throw Exception('can not find an id');
    }
  } else {
    throw Exception(response.toString());
  }
}