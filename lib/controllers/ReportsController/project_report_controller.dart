import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:expense_manager/db_services/database.dart';

class ProjectReportController extends GetxController {
  var paymentReportFormKey = GlobalKey<FormState>().obs;
  var auth = FirebaseAuth.instance;
  final roundLoadingPaymentReportContr =
      new RoundedLoadingButtonController().obs;

  // @override
  // void onInit() async {
  //   projectList.bindStream(
  //       Database().getOnPmAllProjects(FirebaseAuth.instance.currentUser.uid));
  // }
}
