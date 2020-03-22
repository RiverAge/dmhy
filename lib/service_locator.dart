
import 'package:dmhy/repository/login/login_respository.dart';
import 'package:dmhy/repository/torrent/torrent_repository.dart';
import 'package:dmhy/repository/user/user_repository.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
void setup() {
  sl.registerSingleton<UserRepository>(UserRepository());
  sl.registerSingleton<LoginRepository>(LoginRepository());
  sl.registerSingleton<TorrentRepository>(TorrentRepository());
}
