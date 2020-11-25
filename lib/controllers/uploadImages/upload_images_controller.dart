import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/models/image_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';

class UploadImagesController extends GetxController {
  var images = List<Asset>().obs;
  var listOfImages = <NetworkImage>[].obs;

  var error = "no error found".obs;
  var imageUrls = <String>[].obs;
  var isUploading = false.obs;
  var numberOfImages = 0.obs;

  /* void uploadImages() {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          FirebaseFirestore.instance
              .collection('images')
              .doc(documnetID)
              .set({'urls': imageUrls}).then((_) {
            Get.snackbar('success', 'uploaded ');
            // widget.globalKey.currentState.showSnackBar(snackbar);
            // setState(() {
            //   images = [];
            //   imageUrls = [];
            // });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }
  }
  */
  void uploadImages() {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        //  imageUrls.add(downloadUrl.toString());
        //  if (imageUrls.length == images.length)
        var image =
            new Images(imageUrl: downloadUrl, date: DateTime.now().toString());
        //    String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
        FirebaseFirestore.instance
            .collection('images')
            .add(image.toMap())
            .then((value) {
          this.numberOfImages.value += 1;
          Get.defaultDialog(
              title: 'Uploaded', middleText: '${this.numberOfImages} uploaded');
        });
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    // String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      // print(resultList.length);
      // print((await resultList[0].getThumbByteData(122, 100)));
      // print((await resultList[0].getByteData()));
      // print((await resultList[0].metadata));
    } on Exception catch (e) {
      this.error.value = e.toString();
    }

    this.images.value = resultList ?? null;
  }

  Future<dynamic> postImage(Asset imageFile) async {
    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('projectImages')
        .child(imageFile.name);

    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }
}
