import 'package:dmhy/model/user/user.dart';
import 'package:meta/meta.dart';

class UserRepository {
  Future<User> fetch({@required String token, @required String uid}) async {
    return User();
  }
}
