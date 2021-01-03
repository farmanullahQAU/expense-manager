import 'package:expense_manager/ui/pm_uis/report_tab.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:expense_manager/controllers/NotificationPlugin/pushNotification.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PmHomeTabNavController extends GetxController {
  RxInt navSelectedIndex = 0.obs;
  var tabTitle = 'Add new'.obs;


  //RxList<String> adminActionTabs = ["Customers"].obs;

  set setNavSelectedIndex(int index) => navSelectedIndex.value = index;
  int get getNavSelectedIndex => navSelectedIndex.value;

  void clear() {
    tabTitle.value = 'Add new';
  }

 
}
