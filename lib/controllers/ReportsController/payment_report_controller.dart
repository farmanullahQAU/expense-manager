import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editable/editable.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../select_project_controller.dart';

class PaymentReportController extends GetxController {
  var cols = [].obs;
  var currProject = Project().obs;
  var projectList = List<Project>().obs;
  var paymentTypeList = List<PaymentType>().obs;
  var currPaymentType = PaymentType().obs;
  var paymentReportFormKey = GlobalKey<FormState>().obs;
  final roundLoadingPaymentReportContr =
      new RoundedLoadingButtonController().obs;

  var allPayments = List<Payment>().obs;
  var allPaymentModeCash = List<Payment>().obs;
  var allPaymentModeBank = List<Payment>().obs;

  var filterOption = ["Cash", "Bank-Transfer", "Installment", "Regular"].obs;
  var currFilterOption = RxString();

  @override
  void onInit() {
    projectList.bindStream(
        Database().getOnPmAllProjects(FirebaseAuth.instance.currentUser.uid));
    paymentTypeList.bindStream(Database().getPaymentTypes());
    allPayments.bindStream(Database().getppppp());
    allPaymentModeCash.bindStream(Database().getAllCashPayments());
    allPaymentModeBank.bindStream(Database().getAllBankPayments());
  }
}
