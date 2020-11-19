import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:get/state_manager.dart';

class UsrController extends GetxController {
  var _currLoggedInUsr = Usr().obs;
  var _userList = RxList<Usr>();
  var currentUserName = RxString();

  Usr get getCurrentUser => _currLoggedInUsr.value;
  set setCurrentUser(Usr currUsr) => this._currLoggedInUsr.value = currUsr;

  List<Usr> get getUserList => _userList;

  // RxString get getCurrUserName => currentUserName.value.obs;
  // // set setCurrUserName(String name) => currentUserName.value = name;
  // set setCurrUserName(String name) {
  //   this.currentUserName.value = name;
  // }

  void clear() {
    _currLoggedInUsr.value = Usr();
  }
}
