import 'package:organiza_app/models/model_group.dart';

class DataUser {
  static final DataUser _instance = DataUser._internal();

  String name = '';
  int id = -1;
  List<ModelGroup> groupList = [];

  factory DataUser() {
    return _instance;
  }

  static void setName(String name) {
    DataUser().name = name;
  }

  static void setId(int id) {
    DataUser().id = id;
  }

  static void setGroups(List<ModelGroup> groupList) {
    DataUser().groupList = groupList;
  }

  String getname() {
    return name;
  }

  DataUser._internal();
}
