import 'dart:io';

import 'package:expense_manager/ui/Chat/search_user.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_iterables/rx_list.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:expense_manager/ui/pm_uis/pm_home.dart';
import 'package:flutter/material.dart';

class PmHomeBottomNavController extends GetxController {
  RxInt bottomNavSeleIndex = 0.obs;
  set setBottomNavSeleIndex(int index) => bottomNavSeleIndex.value = index;
  int get getBottomNavSeleIndex => bottomNavSeleIndex.value;

  RxList<Widget> bottomNavigationPage = [
    PmHomeTabNav(),
    PmHomeTabNav(),
    SearchUsr(),
  ].obs;

  List<Widget> get getBottomNavigationPage => bottomNavigationPage;
}
