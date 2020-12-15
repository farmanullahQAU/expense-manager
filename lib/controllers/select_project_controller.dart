import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SelectProjectController extends GetxController {
  var currentProject = Rx<Project>();

  var projectList = List<Project>().obs;
  var selectProjectFormKey = GlobalKey<FormState>().obs;
  var projectListAdmin = List<Project>().obs;

  @override
  void onInit() async {
    projectList.bindStream(
        Database().getOnPmAllProjects(FirebaseAuth.instance.currentUser.uid));

    projectListAdmin.bindStream(Database().getAdminAllProjects());
  }
}
