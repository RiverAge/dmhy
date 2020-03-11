import 'package:dmhy/model/user/user.dart';
import 'package:meta/meta.dart';

import 'package:dmhy/api/user.dart' as UserAPI;

class UserRepository {
  Future<User> fetch({@required String token, @required String uid}) async {
    return UserAPI.fetchDetail(token, uid);
  }
}
