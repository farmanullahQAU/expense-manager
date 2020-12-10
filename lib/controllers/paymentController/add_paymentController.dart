import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';

import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddPaymentController<T> extends GetxController {
  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController paymentDesTextEditingController =
      TextEditingController();
  var paymentDescContString = RxString();
  var amountVal = RxDouble();

  final roundLoadingAdddPaymentContr = new RoundedLoadingButtonController().obs;

  var accountNoListCurrentIndex = RxInt();

  Rx<TransactionsType> currTransactionType = Rx<TransactionsType>();
  var transactionTypeList = List<TransactionsType>().obs;

  Rx<TransactionMode> currTransactionMode = Rx<TransactionMode>();
  var transactionModeList = List<TransactionMode>().obs;

  Rx<PaymentMode> currPaymentMode = Rx<PaymentMode>();
  var paymentModeList = List<PaymentMode>().obs;

  var authController = Get.put(AuthController());

  var banAccountList = List<Bank>().obs;

  var paymentTypeList = List<PaymentType>().obs;
  var currPaymentType = Rx<PaymentType>();

  final addPaymentFormKey = GlobalKey<FormState>().obs;
  final selectAccountFormKey = GlobalKey<FormState>().obs;

  var vendorList = List<Vendor>().obs;
  Rx<Vendor> currVendor = Rx<Vendor>();

  RxInt vendorListCurrentIndex = 0.obs;
  var currBankVal = Rx<Bank>();

  @override
  void onInit() {
    banAccountList.bindStream(
        Database().getBankAccounts(authController.getLoggedInFirebaseUser.uid));
    paymentModeList.bindStream(Database().getPaymentModes());
    transactionTypeList.bindStream(Database().getPaymentTransactionType());
    transactionModeList.bindStream(Database().getTransactionMode());
    paymentTypeList.bindStream(Database().getPaymentTypes());
    vendorList.bindStream(Database().getVendors());
  }

  addPayment() async {
    var payment = new Payment(
        projectId: Get.find<SelectProjectController>().currentProject.value.id,
        transactionType: this.currTransactionType.value.transactionType,
        vendor: this.currVendor.value,
        transactionMode: this.currTransactionMode.value.transactionMode,
        paymentType: this.currPaymentType.value.paymentType,
        mode: this.currPaymentMode.value.mode,
        description: this.paymentDescContString.value,
        totalAmount: this.amountVal.value,
        bank: this.currBankVal.value,
        projectManager: Get.find<UsrController>().currLoggedInUsr.value);

    try {
      await Database().addPaymentToDB(payment);
      this.roundLoadingAdddPaymentContr.value.success();
      Get.snackbar("Contrages", 'Payment added successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      print('add payment error');
      print(error.toString());
      String errorMessage = handleError(error);
      Get.dialog(AlertDialog(
        title: Text('Error!'),
        content: Text(errorMessage),
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
      this.roundLoadingAdddPaymentContr.value.stop();
    }
  }

  clear() {}
}
