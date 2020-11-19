import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/widgets.dart';

class AddPaymentController<T> extends GetxController {
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
  set setcurrPaymentMode(val) => currPaymentMode.value = val;
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

/*++++++++++++++++++++++ payment description++++++++++++++++++++*/
  TextEditingController paymentDescTextEditingController =
      TextEditingController();
  RxString paymentDescContString = RxString();
  set setAddPaymentDesc(String val) => paymentDescContString?.value = val;
  String get getPaymentDescString => paymentDescContString?.value;
/*++++++++++++++++++++++ payment description++++++++++++++++++++*/

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

  TextEditingController amountTextEditingController = TextEditingController();
  var amountVal = RxDouble();
  set setAmount(double val) => amountVal.value = val;
  double get getPaymentAmount => amountVal?.value;

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
    String tranType = this.getCurrTransaction.transactionType;
    var payment = new Payment(
        transactionType: tranType,
        vendor: this.getcurrVendor,
        transactionMode: this.getCurrTransactionMode.transactionMode,
        paymentType: this.getcurrPaymentType.paymentType,
        mode: this.getcurrPaymentMode ?? this.currBankVal,
        description: this.getPaymentDescString,
        totalAmount: this.getPaymentAmount);

    //       try {

    //   await Database().addProjectToDb3(project);
    //   Get.snackbar("Contrages", 'Your Project is added',
    //       snackPosition: SnackPosition.BOTTOM);
    // } catch (error) {
    //   print('add project error');
    //   print(error.toString());
    //   String errorMessage = handleError(error);
    //   Get.dialog(AlertDialog(
    //     title: Text('Error!'),
    //     content: Text(errorMessage),
    //     actions: [
    //       FlatButton(
    //         //  textColor: Color(0xFF6200EE),
    //         onPressed: () {
    //           Get.back();
    //         },
    //         child: Text('Cancel'),
    //       ),
    //     ],
    //   ));
    // }
  }
}
