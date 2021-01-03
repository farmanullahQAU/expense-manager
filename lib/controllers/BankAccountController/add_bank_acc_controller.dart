import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddBankAccountController extends GetxController {
  var auth = FirebaseAuth.instance;
  var bankName = RxString();
  var accountNo = RxString();
  var logUrl = RxString();
  var isExists = false.obs;
  var bankAccountTextEditingController = TextEditingController();

  final roundLoadingAddAccount = new RoundedLoadingButtonController().obs;
  final addAccountFormKey = GlobalKey<FormState>().obs;
  List<Map<String, dynamic>> banks = [
    {
      'bankName': 'Meezan',
      'logoUrl':
          'https://tribune-reloaded.s3.amazonaws.com/media/images/1608229-meezan_bankPHOTO-1515908279/1608229-meezan_bankPHOTO-1515908279.jpg'
    },
    {
      'bankName': 'HBL',
      'logoUrl':
          'https://financialallianceforwomen.org/wp-content/uploads/2015/07/Profile_HBL-Logo.png'
    },
    {
      'bankName': 'Askari',
      'logoUrl':
          'https://e7.pngegg.com/pngimages/690/361/png-clipart-karachi-askari-bank-logo-habib-metropolitan-bank-ltd-bank-blue-angle.png'
    },
    {
      'bankName': 'UBL',
      'logoUrl':
          ' https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS_0lc74I7KZ7ZNF2lEldytGXUKuonFgrnFfw&usqp=CAU'
    },
  ];

  addAccount() async {
    var bank = new Bank(
        bankName: this.bankName.value,
        accountNo: this.bankAccountTextEditingController.text,
        logoUrl: this.logUrl.value);
    try {
      if (await Database()
          .isAccountExist(auth.currentUser.uid, bank.bankName)) {
        this.roundLoadingAddAccount.value.stop();
        this.isExists.value = true;
      } else {
        await Database().addBankAccountToDB(bank, auth.currentUser.uid);
        this.roundLoadingAddAccount.value.success();
        this.isExists.value = false;
      }
    } catch (error) {
      print(error);
      var errorMessage = handleError(error);
      Get.defaultDialog(title: 'Error', middleText: errorMessage.toString());
    }
  }
}
