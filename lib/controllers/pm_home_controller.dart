import 'package:get/state_manager.dart';

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
