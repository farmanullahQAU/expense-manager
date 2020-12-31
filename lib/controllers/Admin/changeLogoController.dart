
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChangeLogoController extends GetxController{
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
        .child('logo')
        .child(DateTime.now().toString());
    var storageUploadTask = storageReference.putFile(this.image.value);
    storageUploadTask.onComplete.then((value) {
      StorageTaskSnapshot storageTaskSnapshot;
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((value) {
          this.photoUrl.value = value;
          FirebaseFirestore.instance
              .collection("SplashLogo")
              .doc('logo')
              .update({'logoUrl': this.photoUrl.value}).then((value) {
            Fluttertoast.showToast(msg: 'Updated Successfully', backgroundColor: Colors.blue);
           
          });
        }, onError: (error) {
          Fluttertoast.showToast(msg: error.toString());
        });
      }
    });
  }

}