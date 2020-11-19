import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/project_contract_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class AddProjectController extends GetxController {
  void onInit() async {
    //_customerList = Database().getAllCutomers();
    _customerList.bindStream(Database().getCutomers());
    listProjContracts.bindStream(Database().getProjectContracts());
    pickedDate = DateTime.now().obs;
    getCurrentPm(); //to set currentPm
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    this.relationController.dispose();
    this.remarksController.dispose();
    this.estimatedCostController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get getformKey => formKey.value;

  /*--------project manager who added------*/

  Rx<Usr> currentPm;
  Usr get getCurrPm => currentPm.value;

  /*--------project manager whow added------*/

  /*--------Refresh Controller package------*/
  Rx<RefreshController> refreshController =
      RefreshController(initialRefresh: false).obs;
  RefreshController get getRefreshController => refreshController.value;

  /*--------Refresh Controller package------*/

  /*..................start date ...................*/
  Rx<DateTime> pickedDate = DateTime.now().obs;
  setStarDate(DateTime selected) {
    pickedDate.value = selected;
  }

  DateTime get getStartDate => pickedDate.value;
  /*....................start date .......................*/

  /*..................end date ...................*/
  Rx<DateTime> pickedEndDate = DateTime(DateTime.now().year + 2).obs;
  setEndDate(DateTime selected) => pickedEndDate.value = selected;
  DateTime get getEndDate => pickedEndDate?.value;
  /*....................end date .......................*/

/*---------------------text editing controllers------------------------------*/
  TextEditingController relationController = TextEditingController();
  RxString relationContString = RxString();
  set setRelationString(String val) => relationContString?.value = val;
  String get getRelationString => relationContString?.value;

/*----------------------------text editing controllers--------------------------*/

/*--------------------- remarks controller ------------------------------*/
  TextEditingController remarksController = TextEditingController();
  RxString remarksString = RxString();
  set setRemarksString(String val) => remarksString?.value = val;
  String get getRemarkString => remarksString?.value;

/*----------------------------remarks controller--------------------------*/

/*--------------------- estimated cost  ------------------------------*/
  TextEditingController estimatedCostController = TextEditingController();
  RxDouble estimatedCost = RxDouble();
  set setEstCost(double val) => estimatedCost?.value = val;
  double get getEstCost => estimatedCost?.value;

/*----------------------------estimated cost--------------------------*/

  /*...............project contracts....................*/
  RxList<ProjectContracts> listProjContracts = RxList<ProjectContracts>();
  List<ProjectContracts> get getProContracts => listProjContracts;
  var currProjContract = Rx<ProjectContracts>();
  set setCurrProjContractal(ProjectContracts contract) =>
      currProjContract.value = contract;
  ProjectContracts get getcurrProjContract => currProjContract.value;
  /*......................project contracts..................*/
  /*>>>>>>>>>>>>>>>>>>>> customer list >>>>>>>>>>>>>>>>>>*/
  Rx<Usr> currSelCustomer = Rx<Usr>();
  var _customerList = List<Usr>().obs;
  List<Usr> get getCustomerList => _customerList;

  set setCurrSelCustomer(Usr usr) => currSelCustomer?.value = usr;
  Usr get getCurrSelCustomer => currSelCustomer.value;
/*>>>>>>>>>>>>>>>>>>>> customer list >>>>>>>>>>>>>>>>>>*/

  addProject(
      {Usr customer,
      Usr projectManager,
      ProjectContracts projectContract,
      String custRelationText,
      String custRemarksString,
      DateTime starDate,
      DateTime endDate,
      double estimatedCost}) async {
    try {
      var project = new Project(
          /*instance of project*/

          customer: customer,
          projectContract: projectContract,
          customerRelation: custRelationText,
          customerRemarks: custRemarksString,
          estimatedCost: estimatedCost,
          projectManager: projectManager);
      await Database().addProjectToDb3(project);
      Get.snackbar("Contrages", 'Your Project is added',
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      print('add project error');
      print(error.toString());
      String errorMessage = handleError(error);
      Get.dialog(AlertDialog(
        title: Text('Error!'),
        content: Text(errorMessage),
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
    }
  }

  fetchData() {
    this._customerList.bindStream(Database().getCutomers());
    this.listProjContracts.bindStream(Database().getProjectContracts());
  }

  clearFields() {
    this.relationController.clear();
    this.remarksController.clear();
    this.estimatedCostController.clear();
    super.dispose();
  }

  getCurrentPm() async {
    Usr currPm =
        await Database().getUser(FirebaseAuth.instance.currentUser.uid);
    this.currentPm = currPm.obs;
  }
}
