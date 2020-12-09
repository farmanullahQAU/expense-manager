import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/labor_model.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddLaborController extends GetxController {
  var contractDetailsTextController = TextEditingController().obs;
  var contractNameTextController = TextEditingController().obs;

  TextEditingController amountTextEditingController = TextEditingController();
  final phoneNumberTextController = TextEditingController().obs;
  final nameTextController = TextEditingController().obs;
  final addressTextController = TextEditingController().obs;
  final laborTypeTextController = TextEditingController().obs;

  var address = RxString();
  var name = RxString();
  var phone = RxString();
  var amount = RxDouble();
  var contractDetails = RxString();
  var contract = Rx<LaborContract>();

  var paymentTypes = ['Contract-Base', 'Daily-Wage-Base'].obs;

  var currPaymentType = RxString();

  final addlaborFormKey = GlobalKey<FormState>().obs;

  var laborTypes = List<LaborTypes>().obs;
  var currLaborType = LaborTypes().obs;
  final contractDetailsFormKey = GlobalKey<FormState>().obs;

  String initialCountry = 'PK';
  var number = PhoneNumber(isoCode: 'PK', dialCode: '+92').obs;
  var isValidPhone = RxBool();
  final roundLoadingAddLabor = new RoundedLoadingButtonController().obs;

  @override
  void onInit() {
    laborTypes.bindStream(Database().getLaborTypes());
  }

  // void getPhoneNumber(String phoneNumber, String dialCode) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, dialCode);

  //   this.number.value = number;
  //   print(this.number.toString());
  // }

  /* @override
  void dispose() {
    phoneNumberTextController.value?.dispose();
    super.dispose();
  }
  */

  addLabor() async {
    var laborObj = Labor(
        laborProjectIds: [
          Get.find<SelectProjectController>().currentProject.value.id
        ],
        name: this.name.value,
        laborType: currLaborType.value.laborType,
        paymentType: this.currPaymentType.value,
        amount: this.amount.value,
        phone: this.number.value.phoneNumber,
        address: this.address.value,
        contract: this.contract.value);

    try {
      await Database().addLaborToDb(laborObj);
      this.roundLoadingAddLabor.value.success();
      Get.snackbar("Success", ' Labor added successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      print('add labor error');
      print(error.toString());
      //  String errorMessage = handleError(error);
      Get.dialog(AlertDialog(
        title: Text('Error!'),
        content: Text(error),
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
      this.roundLoadingAddLabor.value.stop();
    }
  }
}
