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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_manager/models/user_model.dart';

class Root extends GetWidget {
  var authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (_) {
        if (authController.firebaseLoggedInuser.value != null) {
          return Splash();
        } else {
          print('login page');
          return Login1();
        }
      },
    );
  }
}

class Splash extends GetWidget<UsrController> {
  var authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetX(
          initState: (_) async {
            controller.currentUsr.value = await Database()
                .getUser(authController.firebaseLoggedInuser.value.uid);
          },
          builder: (_) {
            if (authController.firebaseLoggedInuser.value == null) {
              print('login 2');
              return Login1();
            }
            if (controller.currentUsr.value.userType == "Project manager") {
              controller.usrType.value = controller.currentUsr.value.userType;
              return PmHomeBottomNav();
            }
            if (controller.currentUsr.value.userType == "Admin") {
              controller.usrType.value = controller.currentUsr.value.userType;

              return PmHomeBottomNav();
            }


            if (controller.currentUsr.value.userType == "Customer") {
              controller.usrType.value = controller.currentUsr.value.userType;

              return PmHomeBottomNav();
            }
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
        ),
      ),
    );
  }
}
