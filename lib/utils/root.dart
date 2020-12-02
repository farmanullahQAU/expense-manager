import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/ui/add_customer.dart';
import 'package:expense_manager/ui/admin_ui/login1.dart';

import 'package:expense_manager/ui/pm_uis/pm_home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
              //     child: SpinKitFadingCircle(
              //       size: ,
              //   color: Theme.of(context).primaryColor,
              // )

              child: SizedBox(
                width: 200.0,
                height: 100.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.green,
                  highlightColor: Colors.yellow,
                  child: Column(
                    children: [
                      SpinKitFadingCircle(
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        'Loading Profile...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
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
