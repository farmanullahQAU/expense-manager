import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
class AddCustomerOrpmController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  var formKey = GlobalKey<FormState>().obs;
  var pmOrCustomer=RxString();
   String initialCountry = 'PK';
  final phoneNumberTextController = TextEditingController().obs;

  var number = PhoneNumber(isoCode: 'PK', dialCode: '+92').obs;
  var isValidPhone = RxBool();


  addUsr(){



      _authController.createUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                adrs: addresController.text,
                                ph: phoneNumberTextController.value.text,
                                usrType: pmOrCustomer.value);
  }


}