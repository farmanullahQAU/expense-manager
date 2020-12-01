import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../errorHandler.dart';
import '../user_controller.dart';

class ProfileController extends GetxController {
  var userController = Get.put(UsrController());
  final errorController = Get.put(ErrorController());
  var imagePicker = ImagePicker();
  var image = Rx<File>();
  var photoUrl = Rx<String>();
  Future choseImage() async {
    try {
      final pickedFile =
          await imagePicker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
        uploadToDataBase();
      } else
        Fluttertoast.showToast(msg: 'no images selected');
    } catch (err) {
      Fluttertoast.showToast(msg: err);
    }
  }

  uploadToDataBase() async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('profileImages')
        .child(userController.currLoggedInUsr.value.id);
    var storageUploadTask = storageReference.putFile(this.image.value);
    storageUploadTask.onComplete.then((value) {
      StorageTaskSnapshot storageTaskSnapshot;
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((value) {
          this.photoUrl.value = value;
          FirebaseFirestore.instance
              .collection("users")
              .doc(this.userController.currLoggedInUsr.value.id)
              .update({'photoUrl': this.photoUrl.value}).then((value) {
            Fluttertoast.showToast(msg: 'Updated successfully');
            userController.currLoggedInUsr.value.photoUrl =
                this.photoUrl.value; //update locally
            // userController.currLoggedInUsr.refresh();
          });
        }, onError: (error) {
          var err = errorController.handleStorageError(error);
          Fluttertoast.showToast(msg: err);
        });
      }
    });
  }

  // void onInit() async {
  //   print('Profile controller');
  //   firebaseLoggedInuser.bindStream(auth.authStateChanges());
  // }
}
