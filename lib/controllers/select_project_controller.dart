import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:expense_manager/controllers/user_controller.dart';

class SelectProjectController extends GetxController {
  var currentProject = Rx<Project>();

  var projectListPm = List<Project>().obs;
  var selectProjectFormKey = GlobalKey<FormState>().obs;
  var projectListAdmin = List<Project>().obs;
  var projectListCustomer = List<Project>().obs;
  var currUsrController=Get.find<UsrController>();



  @override
  void onInit()  {
    projectListPm.bindStream(
        Database().getOnPmAllProjects(currUsrController.currentUsr.value.id));

    projectListAdmin.bindStream(Database().getAdminAllProjects());
    projectListCustomer.bindStream(Database().getCustomerAllProjects(currUsrController.currentUsr.value.id));



  }
}
