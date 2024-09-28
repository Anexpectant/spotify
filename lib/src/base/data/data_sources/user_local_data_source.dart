import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/src/base/data/data_sources/base_local_data_source.dart';
import 'package:spotify/src/base/data/models/user.dart';

@Singleton(env: [Environment.dev])
class BaseUserLocalDataSource extends LocalDataSource {
  static const String userBox = "user";

  @override
  exec() async {
    await Hive.openBox<User>(userBox);
  }

  addUser(User user) async {
    final box = await Hive.openBox<User>(userBox);
    box.put(user.id, user);
  }

  removeChild(String userId) async {
    final box = await Hive.openBox<User>(userBox);
    box.delete(userId);
  }

  removeUser() async {
    (await Hive.openBox<User>(userBox)).clear();
  }
}
