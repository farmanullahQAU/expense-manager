import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/pm_hom_botom_Nav_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/ui/add_customer.dart';
import 'package:expense_manager/ui/admin_ui/login1.dart';

import 'package:expense_manager/ui/pm_uis/pm_home.dart';

import 'package:expense_manager/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Root extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return GetX(builder: (_) {
      if (Get.find<AuthController>().getLoggedInFirebaseUser?.uid != null) {
        return Splash();
      }
      print('loglin');
      return Login1();
    });
  }
}

class Splash extends GetWidget<UsrController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetX(
          builder: (_) {
            if (controller.currLoggedInUsr.value == null) {
              print('login 2');
              return Login1();
            }
            if (controller.currLoggedInUsr.value.userType ==
                "Project manager") {
              return PmHomeBottomNav();
            }
            if (controller.currLoggedInUsr.value.userType == "Customer")
              return AddCustomer();
            return Center(
                child: SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
            ));
          },
          initState: (_) async {
            controller.currLoggedInUsr.value = await Database().getUser(
                Get.find<AuthController>().getLoggedInFirebaseUser.uid);
          },
        ),
      ),
    );
  }
}
