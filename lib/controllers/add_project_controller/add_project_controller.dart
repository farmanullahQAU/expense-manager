import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
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
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddProjectController extends GetxController {
  var usrcontroller = Get.put(UsrController());
  var flag = false.obs;
  final roundLoadingButtonController = new RoundedLoadingButtonController().obs;

  void onInit() async {
    flag = false.obs;
    //_customerList = Database().getAllCutomers();
    _customerList.bindStream(Database().getCutomers());
    listProjContracts.bindStream(Database().getProjectContracts());
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

  /*--------Refresh Controller package------*/
  Rx<RefreshController> refreshController =
      RefreshController(initialRefresh: false).obs;
  RefreshController get getRefreshController => refreshController.value;

  /*--------Refresh Controller package------*/

  /*..................start date ...................*/
  var startDate = Rx<DateTime>();
  /*....................start date .......................*/

  /*..................end date ...................*/
  var dateEnd = Rx<DateTime>();

  /*....................end date .......................*/

/*---------------------text editing controllers------------------------------*/
  TextEditingController relationController = TextEditingController();
  TextEditingController startDateTextEditingController =
      TextEditingController();

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
  var currSelCustomer = Rx<Usr>();
  var _customerList = List<Usr>().obs;
  List<Usr> get getCustomerList => _customerList;

  set setCurrSelCustomer(Usr usr) => currSelCustomer?.value = usr;
  Usr get getCurrSelCustomer => currSelCustomer.value;
/*>>>>>>>>>>>>>>>>>>>> customer list >>>>>>>>>>>>>>>>>>*/

  addProject() async {
    try {
      /* var project = new Project(
          /*instance of project*/

          customer: this.currSelCustomer.value,
          projectContract: this.currProjContract.value,
          customerRelation: this.relationContString.value,
          customerRemarks: this.remarksString.value,
          estimatedCost: this.estimatedCost.value,
          projectManager: usrcontroller.currLoggedInUsr.value);
          */

      var project = new Project(
          /*instance of project*/

          customer: this.currSelCustomer.value,
          projectContract: this.currProjContract.value,
          customerRelation: this.relationContString.value,
          customerRemarks: this.remarksString.value,
          estimatedCost: this.estimatedCost.value,
          projectPmIds: [usrcontroller.currLoggedInUsr.value.id]);

      await Database().addProjectToDb4(project);

      Get.snackbar("Contrages", 'Your Project is added',
          snackPosition: SnackPosition.BOTTOM);
      this.roundLoadingButtonController.value.success();
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
    this.currSelCustomer = currPm.obs;
  }
}
