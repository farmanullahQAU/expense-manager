import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:expense_manager/models/project_contract_model.dart';
import 'package:expense_manager/controllers/user_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:expense_manager/models/labor_model.dart';

class FetchProjectController extends GetxController {
  var usrController = Get.put(UsrController());
  var userType = RxString();

  var contractDesString = RxString();
  var contractNameString = RxString();
  var isUpdate = false.obs;
  var projectReference = Rx<DocumentReference>();

  var allPmProjects = List<Project>().obs;
  var allAdminProjects = List<Project>().obs;
  var allCustomesrProject = List<Project>().obs;

  var projectAllLabors = List<Labor>().obs;
  var totalWagesAmounts = RxDouble();

  @override
  void onInit() async {
    // projectAllLabors.bindStream(Database().getAllWager(
    //   projectReference.value.id,
    // ));
    userType.value = usrController.currentUsr.value.userType;
    allPmProjects.bindStream(
        Database().getOnPmAllProjects(usrController.currentUsr.value.id));
    allAdminProjects.bindStream(Database().getAdminAllProjects());
    allCustomesrProject.bindStream(
        Database().getCustomerAllProjects(usrController.currentUsr.value.id));
  }
}
