import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:expense_manager/models/project_contract_model.dart';

class ProjectContractController extends GetxController {
  var allProjectContracts = List<ProjectContracts>().obs;
  @override
  void onInit() async {
    allProjectContracts.bindStream(Database().getProjectContracts());
  }
}
