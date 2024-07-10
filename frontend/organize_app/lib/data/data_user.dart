import 'package:organiza_app/models/model_group.dart';

class UserData {
  static final UserData _instance = UserData._internal();

  String username = '';
  int id = -1;
  List<ModelGroup> groupList = [];

  factory UserData() {
    return _instance;
  }

  static void setUsername(String username) {
    UserData().username = username;
  }

  static void setId(int id) {
    UserData().id = id;
  }

  static void setGroups(List<ModelGroup> groupList) {
    UserData().groupList = groupList;
  }

  String getUsername() {
    return username;
  }

  UserData._internal();
}
