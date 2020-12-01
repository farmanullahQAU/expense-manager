import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SendMessageController extends GetxController {
  var sender = Usr().obs;
  var receiver = Usr().obs;
  // var title = RxString();
  // var id = RxString();
  var usr = Get.arguments;
  var isEmojiOpen;
  var isLoading;
  final textEditingController = TextEditingController().obs;
  var focusNode = FocusNode().obs;
  //send image
  var imagefile = Rx<File>();
  var sentImageUrl = RxString();
  final imagePicker = ImagePicker();
  var chatId = RxString();
  final listScrollContrller = ScrollController().obs;
  var listMessages = RxList();

  @override
  void onInit() {
    isEmojiOpen = false.obs;
    isLoading = false.obs;

    // this.chatId.value = "";
    // focusNode.addListener(onFocusChange());
    // readLocal();
  }

  onFocusChange() {
    if (this.focusNode.value.hasFocus) {
      this.isEmojiOpen = false;
    }
  }

  getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      this.imagefile.value = File(pickedFile.path);
      this.isLoading = true;
    }
    uploadImageFile();
  }

  void uploadImageFile() async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Chat images").child(fileName);
    StorageUploadTask storageUploadTask =
        storageReference.putFile(this.imagefile.value);
    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUr) {
      this.sentImageUrl.value = downloadUr;
      this.isLoading = false;

      onSendMessage(this.sentImageUrl.value, 1);
    }, onError: (error) {
      this.isLoading = false;
      Fluttertoast.showToast(msg: "error" + error);
    });
  }

  onSendMessage(String contentMsg, int type) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(this.sender.value.id)
        .update({'chatWith': this.receiver.value.id});
    //reload local aboove

    if (contentMsg != "") {
      this.textEditingController.value.clear();
      var docRef = FirebaseFirestore.instance
          .collection("messages")
          .doc(this.chatId.value)
          .collection(this.chatId.value)
          .doc(DateTime.now().microsecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(docRef, {
          "idFrom": this.sender.value.id,
          "idTo": this.receiver.value.id,
          "timestamp": DateTime.now().microsecondsSinceEpoch.toString(),
          "content": contentMsg,
          "type": type,
        });
      });
      // this.listScrollContrller.value.animateTo(0.0,
      //     duration: Duration(microseconds: 300), curve: Curves.easeOut);
    }
  }
/*
  void readLocal() async {
   
    if (this.sender.value.id.hashCode <= this.receiver.value.id.hashCode) {
      this.chatId.value = '${sender.value.id}-${receiver.value.id}';
    } else {
      this.chatId.value =
          this.chatId.value = '${receiver.value.id}-${sender.value.id}';
    }

    FirebaseFirestore.instance
        .collection("users")
        .doc(this.sender.value.id)
        .update({'chatWith': this.receiver.value.id});
        
  }
  */

  void setChatId() {
    if (this.sender.value.id.hashCode <= this.receiver.value.id.hashCode) {
      this.chatId.value = '${sender.value.id}-${receiver.value.id}';
    } else {
      this.chatId.value =
          this.chatId.value = '${receiver.value.id}-${sender.value.id}';
    }
  }
}
