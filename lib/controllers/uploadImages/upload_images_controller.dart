import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/errorHandler.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/image_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/ui/uploads_images/upload_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expense_manager/controllers/user_controller.dart';

class UploadImagesController extends GetxController {
  var errorController = Get.put(ErrorController());
  var slectedProjecCont = Get.find<SelectProjectController>();
  var usrController = Get.find<UsrController>();


  var fetchImages = List<NetworkImage>().obs;
  var images = List<Asset>().obs;
  var listOfImages = <NetworkImage>[].obs;

  var error = "no error found".obs;
  var imageUrls = <String>[].obs;
  var numberOfImages = RxInt();
  var projectList = List<Project>().obs;
  var uploadPicFormKey = GlobalKey<FormState>().obs;
  var progress = RxDouble();

  @override
  void onInit() async {
    numberOfImages.value = 0;
    images.value = [];

    projectList.bindStream(
        Database().getOnPmAllProjects(FirebaseAuth.instance.currentUser.uid));
  }

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
  void uploadImages(context) {
    Fluttertoast.showToast(msg: "Uploading...", backgroundColor: Colors.black);
    for (var imageFile in images) {
      postImage(imageFile, context).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        var image = new Images(
          uploadedBy: usrController.currentUsr.value.name,
            imageUrl: downloadUrl,
            date: DateTime.now(),
            projectId: slectedProjecCont.currentProject.value.id);
        FirebaseFirestore.instance
            .collection('Projects')
            .doc(slectedProjecCont.currentProject.value.id)
            .collection('Pictures')
            .add(image.toMap())
            .then((value) {
          if (imageUrls.length == images.length)
          {

            
            Fluttertoast.showToast(
                msg: "All images uploaded ", backgroundColor: Colors.green);
                Get.toNamed('fetchImagesUi');
          }
        });
      }).catchError((err) {
    Get.defaultDialog(title:'Error', middleText:err.toString(), onCancel:()=>Get.back(),  );
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

  Future<dynamic> postImage(Asset imageFile, context) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference reference =
          FirebaseStorage.instance.ref().child('projectImages').child(fileName);

      StorageUploadTask uploadTask = reference
          .putData((await imageFile.getByteData()).buffer.asUint8List());
      uploadTask.events.listen((event) {
        /*     event.snapshot.totalByteCount.toDouble();

      Get.defaultDialog(
          backgroundColor: null,
          content: Center(
              child:
                  Text('Uploading ${(progress * 100).toStringAsFixed(2)} %')),
          title: this.progress.value.toString(),
          middleText: '${(progress * 100).toStringAsFixed(2)} %');

      // Center(child: Text('Uploading ${(progress * 100).toStringAsFixed(2)} %'));
      */
      });

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      //  Get.back();
      return storageTaskSnapshot.ref.getDownloadURL();
    } catch (err) {
      errorController.errorString.value =
          errorController.handleStorageError(err);
    Get.defaultDialog(title:'Error', middleText:err.toString(), onCancel:()=>Get.back(),  );

    }
  }
}
