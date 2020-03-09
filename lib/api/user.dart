import 'package:http/http.dart' as http;

void fetchDetail(String cookie, String uid) async {
  final response = await http.get('https://u2.dmhy.org/userdetails.php?id=$uid');

  
}