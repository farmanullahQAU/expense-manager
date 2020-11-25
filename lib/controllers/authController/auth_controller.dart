import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:expense_manager/ui/add_customer.dart';
import 'package:expense_manager/ui/pm_uis/pm_home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../pm_home_controller.dart';
import 'auth_error_handler_controller.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AuthController extends GetxController {
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      var actionCode = deepLink.queryParameters['oobCode'];

      try {
        await auth.checkActionCode(actionCode);
        await auth.applyActionCode(actionCode);

        // If successful, reload the user:
        auth.currentUser.reload();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-action-code') {
          print('The code is invalid.');
        }
      }

      if (deepLink != null) {
        Get.to(AddCustomer());
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      // Navigator.pushNamed(context, deepLink.path);
    }
  }

  var userController = Get.put(UsrController());
  var pmHomeTabNavController = Get.put(PmHomeTabNavController());

  FirebaseAuth auth = FirebaseAuth.instance;
  var _firebaseLoggedInuser = Rx<User>();
  User get getLoggedInFirebaseUser => _firebaseLoggedInuser?.value;
  /*---------------------------login form key------------------*/
  final loginFormKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get getLoginformKey => loginFormKey.value;
  /*-------------------------login form key--------------------*/
  // Rx<Usr> currentUsr;
  // set setCurrentUsr(val) => currentUsr.value = val;
  //Usr get getCurrentUser => currentUsr.value;

  RxString errorString = RxString();
  set setErrorString(error) => errorString.value = error;
  String get getErrorString => errorString.value;

  @override
  void onInit() async {
    print('AuthCnrl...... called');
    _firebaseLoggedInuser.bindStream(auth.authStateChanges());
  }

  void createUser(
      {String email,
      String password,
      String name,
      String adrs,
      String usrType,
      String ph}) async {
    try {
      FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
      Get.dialog(Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ));

      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Usr _student = new Usr(
          id: userCred.user.uid,
          name: name,
          email: email,
          address: adrs,
          phone: ph,
          userType: usrType);

      await Database().createNewUser(_student);
      Get.back();
      Get.snackbar('Sucess', 'Account created successfully');
    } on FirebaseException catch (err) {
      Get.defaultDialog(title: err.toString(), radius: 20);
      Get.back();
    }
  }

  void login(String email, String password) async {
    try {
      Get.defaultDialog(
          title: " ",
          radius: 0.0,
          barrierDismissible: false,
          content: Center(
              child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          )));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.back(); /* if user is logged in successfully then first dialogue will clodse */

    } on FirebaseAuthException catch (error) {
      print('login error');
      print(error.toString());
      String erroMessage = handleError(error);
      // Get.snackbar('Error!', erroMessage, snackPosition: SnackPosition.TOP);
      Get.back();
      Get.dialog(AlertDialog(
        title: Text('Error!'),
        content: Text(erroMessage),
        actions: [
          FlatButton(
            //  textColor: Color(0xFF6200EE),
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ));
    }
  }

  void logout() async {
    Get.defaultDialog(
      title: 'logging out...',
      content: CircularProgressIndicator(),
    );
    try {
      await auth.signOut();

      userController.clear();
      pmHomeTabNavController.clear();
      //to remove logged in user from cache locally
      Get.back();
    } on FirebaseAuthException catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }
}
