// import 'package:get/get.dart';

// import 'package:flutter/material.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'auth_error_handler_controller.dart';


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/route_manager.dart';
// import 'package:expense_manager/ui/pm_uis/pm_home.dart';



// class LoginController extends GetxController {
//   final loginKey = GlobalKey<FormState>().obs;
//   final roundLoadingLoginContr = new RoundedLoadingButtonController().obs;
//   var isloading=true.obs;

//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   String email, password;


//   void login(String email, String password) async {

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Get.toNamed('PmHomeBottomNavView');

//       // Get.back(); /* if user is logged in successfully then first dialogue will clodse */

//     } on FirebaseAuthException catch (error) {
//       this.roundLoadingLoginContr.value.stop();
//       print(error.toString());
//       String erroMessage = handleError(error);
//       // Get.snackbar('Error!', erroMessage, snackPosition: SnackPosition.TOP);
//       Get.back();
//       Get.dialog(AlertDialog(
//         title: Text('Error!'),
//         content: Text(erroMessage),
//         actions: [
//           FlatButton(
//             //  textColor: Color(0xFF6200EE),
//             onPressed: () {
//               Get.back();
//             },
//             child: Text('Cancel'),
//           ),
//         ],
//       ));
//     }
//   }

 
// }
