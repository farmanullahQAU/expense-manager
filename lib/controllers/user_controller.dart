import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:get/state_manager.dart';

class UsrController extends GetxController {
  var currLoggedInUsr = Usr().obs;
  var _userList = RxList<Usr>();
  var currentUserName = RxString();

  List<Usr> get getUserList => _userList;

  // RxString get getCurrUserName => currentUserName.value.obs;
  // // set setCurrUserName(String name) => currentUserName.value = name;
  // set setCurrUserName(String name) {
  //   this.currentUserName.value = name;
  // }

  void clear() {
    currLoggedInUsr.value = Usr();
  }
}
