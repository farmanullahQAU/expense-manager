import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_sms/flutter_sms.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InvitationController extends GetxController{



   String initialCountry = 'PK';
  ///final phoneNumberTextController = TextEditingController().obs;

  var number = PhoneNumber(isoCode: 'PK', dialCode: '+92').obs;
  var isValidPhone = RxBool();
  @override
  void onInit() {
   _setTargetPlatformForDesktop();
  }

  var message=RxString();
  
   var body=RxString();
  var people =<String>[].obs;
  var phoneNumberTextController = TextEditingController(text: "").obs;
   var  controllerMessage = TextEditingController(text: "Hi we are here to create your account plz send us your email and password thanks").obs;





  void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}
void _sendSMS(List<String> recipents) async {
    try {
      String _result = await sendSMS(
          message: controllerMessage.value.text, recipients: recipents);
  this. message.value = _result;
    } catch (error) {
    Fluttertoast.showToast(
    
      msg: error.toString());
    }
  }
  // void canISendSMS() async {
  //   bool result = await canSendSMS();
  //   print(result);
  //    canSendSMSMessage .value=
  //       result ? 'This unit can send SMS' : 'This unit cannot send SMS';
  // }
  void send() {
    if (people == null || people.isEmpty) {
    message.value = "Add at least one number to send message";
    } else {
      _sendSMS(people);
    }
  }
}