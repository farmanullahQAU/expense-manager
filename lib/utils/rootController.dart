
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RootController extends GetxController{
   FirebaseAuth auth = FirebaseAuth.instance;
  var firebaseLoggedInuser = Rx<User>();
  @override
  void onInit() async {
  firebaseLoggedInuser.bindStream(auth.authStateChanges());
  }

}
 