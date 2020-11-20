import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
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

/*____________________selected account list inde____________________*/
  RxInt accountNoListCurrentIndex = 0.obs;
  set setAccountNoListCurrIndex(int index) =>
      accountNoListCurrentIndex.value = index;
  int get getAccountNoListCurrIndex => accountNoListCurrentIndex.value;

/*____________________selected account list inde____________________*/

/*@@@@@@@@@@@@@@ Transaction @@@@@@@@@@@@@@@ */
  //RxList<String> transactionType = ['OnSpot', 'AfterExpense', 'Advance'].obs;
  Rx<TransactionsType> currTransactionType = Rx<TransactionsType>();
  set setCurrTransactionType(val) => currTransactionType.value = val;
  TransactionsType get getCurrTransaction => currTransactionType.value;
  var transactionTypeList = List<TransactionsType>().obs;
  List<TransactionsType> get getTransactionTypeList => transactionTypeList;

/*@@@@@@@@@@@@@@ Transaction @@@@@@@@@@@@@@@ */

/*=================== Transaction mode ============== */
  //RxList<String> transactionType = ['OnSpot', 'AfterExpense', 'Advance'].obs;
  Rx<TransactionMode> currTransactionMode = Rx<TransactionMode>();
  set setCurrTransactionMode(val) => currTransactionMode.value = val;
  TransactionMode get getCurrTransactionMode => currTransactionMode.value;
  var transactionModeList = List<TransactionMode>().obs;
  List<TransactionMode> get getTransactionModeList => transactionModeList;

/*=================== Transaction mode ============== */

  /*,,,,,,,,,,,,,,,,,,,,,,,,,payment mode,,,,,,,,,,,,,,,*/
  Rx<PaymentMode> currPaymentMode = Rx<PaymentMode>();
  set setcurrPaymentMode(PaymentMode val) => currPaymentMode.value = val;
  PaymentMode get getcurrPaymentMode => currPaymentMode.value;
  var paymentModeList = List<PaymentMode>().obs;
  List<PaymentMode> get getPaymentModeList => paymentModeList;
  /*,,,,,,,,,,,,,,,,,,,,,,,,,payment mode,,,,,,,,,,,,,,*/

  /* to get current db logged in user */
  var authController = Get.put(AuthController());
/*..................... get and set projectList..............*/
  var _projectList = List<Project>().obs;
  List<Project> get getProjectLIst => _projectList;
  //set setProjectList(Project project) => _projectList.add(project);
/*..................... get and set projectList..............*/

/*------------------- get and set Bank account-----------------------*/
  var banAccountList = List<Bank>().obs;
  List<Bank> get getBanAccountList => banAccountList;

  //set setBanAccountList(Bank bank) => banAccountList.add(bank);
/*------------------- get and set Bank account---------------------*/

/*:::::::::::::::::::::::::payment Type List ::::::::::::::::::::::::::-*/
  var paymentTypeList = List<PaymentType>().obs;
  List<PaymentType> get getPaymentTypeList => paymentTypeList;
  Rx<PaymentType> currPaymentType = Rx<PaymentType>();
  set setcurrPaymentType(val) => currPaymentType.value = val;
  PaymentType get getcurrPaymentType => currPaymentType.value;
/*:::::::::::::::::::::::::payment Type List ::::::::::::::::::::::::::-*/

  Rx<Project> currProject = Rx<Project>();
  set setCurrSelProj(Project usr) => currProject.value = usr;
  Project get getCurrSelProj => currProject.value;
/*...........................add payment formkey...............*/
  final addPaymentFormKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get getformKey => addPaymentFormKey.value;
/*...........................add payment formkey...............*/

/*^^^^^^^^^^^^^^^^^^^^^^Vendor ^^^^^^^^^^^^^^^^^^ */

  var vendorList = List<Vendor>().obs;
  List<Vendor> get getVendorList => vendorList;
  Rx<Vendor> currVendor = Rx<Vendor>();
  set setcurrVendor(val) => currVendor.value = val;
  Vendor get getcurrVendor => currVendor.value;

/*^^^^^^^^^^^^^^^^^^^^^^Vendor ^^^^^^^^^^^^^^^^^^ */

/*____________________selected vendor list inde____________________*/
  RxInt vendorListCurrentIndex = 0.obs;
  set setVendorListCurrentIndex(int index) =>
      vendorListCurrentIndex.value = index;
  int get getVendorListCurrentIndex => vendorListCurrentIndex.value;

/*____________________selected vendor list inde____________________*/

/*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Bank >>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
  var currBankVal = Rx<Bank>();

  set setCurrBank(val) => currBankVal.value;
  Bank get getCurrBank => currBankVal.value;
/*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Bank >>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

  void onInit() {
    _projectList.bindStream(Database()
        .getOnPmAllProjects(authController.getLoggedInFirebaseUser.uid));
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
        projectId: this.getCurrSelProj.id,
        transactionType: this.currTransactionType.value.transactionType,
        vendor: this.currVendor.value,
        transactionMode: this.getCurrTransactionMode.transactionMode,
        paymentType: this.getcurrPaymentType.paymentType,
        mode: this.currPaymentMode.value.mode,
        description: this.paymentDescContString.value,
        totalAmount: this.amountVal.value,
        bank: this.currBankVal.value);

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
}
