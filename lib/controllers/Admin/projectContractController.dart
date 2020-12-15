import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:expense_manager/models/project_contract_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProjectContractController extends GetxController {
  var addContractFormKey = GlobalKey<FormState>().obs;
  var contractNameEditingController = TextEditingController().obs;
  var contractDesEditingController = TextEditingController().obs;
  var contractDesString = RxString();
  var contractNameString = RxString();
  var isUpdate = false.obs;
  var reference = Rx<DocumentReference>();
  var projectContractObj = ProjectContracts().obs;

  var allProjectContracts = List<ProjectContracts>().obs;
  @override
  void onInit() async {
    allProjectContracts.bindStream(Database().getProjectContracts());
  }

  updateContrac() {
    reference.value
        .update({
          'contractName': projectContractObj.value.contractName,
          'contractDesc': projectContractObj.value.contractDesc
        })
        .then((value) => Fluttertoast.showToast(
              msg: "Updated Successfully",
              backgroundColor: Colors.green,
            ))
        .catchError((error) =>
            Get.defaultDialog(title: 'Error', middleText: error.toString()));
  }

  reSet() {
    this.contractNameEditingController.value.clear();
    this.contractDesEditingController.value.clear();
  }
}
