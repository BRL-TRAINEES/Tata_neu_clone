import 'package:hive/hive.dart';
import 'package:tataneu_clone/constants.dart';
import 'package:tataneu_clone/hive/chat_history.dart';
import 'package:tataneu_clone/hive/settings.dart';
import 'package:tataneu_clone/hive/user_model.dart';

class Boxes {
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>(Constants.chatHistoryBox);

  static Box getUser() => Hive.box<UserModel>(Constants.userBox);
  
  static Box getSettings() => Hive.box<Settings>(Constants.settingsBox);
}