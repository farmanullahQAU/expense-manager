import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PaymentReportController extends GetxController {
  var currProject = Project().obs;
  var projectList = List<Project>().obs;
  var paymentTypeList = List<PaymentType>().obs;
  var currPaymentType = PaymentType().obs;
  var paymentReportFormKey = GlobalKey<FormState>().obs;
  var auth = FirebaseAuth.instance;
  final roundLoadingPaymentReportContr =
      new RoundedLoadingButtonController().obs;
  var indx = 0.obs;

  var paymentList = List<Payment>().obs;

  @override
  void onInit() async {
    print('PaymentReportController ');

    projectList.bindStream(
        Database().getOnPmAllProjects(FirebaseAuth.instance.currentUser.uid));
    paymentTypeList.bindStream(Database().getPaymentTypes());
  }
}
