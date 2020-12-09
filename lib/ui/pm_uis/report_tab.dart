import 'package:expense_manager/controllers/ReportsController/payment_report_controller.dart';
import 'package:expense_manager/controllers/ReportsController/project_report_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Reports extends GetWidget {
  var paymentReportController = Get.put(PaymentReportController());
  var projectReportController = Get.put(ProjectReportController());

  var addPaymentController = Get.put(SelectProjectController());

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 2 : 3,
          children: [
            InkWell(
              child: addCard(
                  context, Colors.green, 'Project Report', Icons.person),
              onTap: () {
                projectReportDialogue(context);
              },
            ),
            InkWell(
              child: addCard(context, Colors.red, ' Payment Report ',
                  Icons.account_balance_wallet),
              onTap: () {
                showSelectPaymentAndProjectDialog(context);
              },
            ),
            addCard(context, Colors.purple, 'Labor Report', Icons.work),
            addCard(context, Colors.deepOrangeAccent, 'Material Report',
                Icons.subway),
            InkWell(
              onTap: () {},
              child: addCard(
                context,
                Colors.amber,
                'Vendor Report',
                Icons.polymer,
              ),
            ),
          ],
        ));
  }

  addCard(BuildContext context, Color color, String title, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      borderOnForeground: true,
      semanticContainer: false,
      margin: EdgeInsets.all(5),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Icon(
              icon,
              color: Get.isDarkMode ? Theme.of(context).accentColor : color,
              size: context.isLandscape ? 40 : 40,
            ),
          ),
          Text(title,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
        ],
      )),
    );
  }

  showSelectPaymentAndProjectDialog(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false, //enable and disable outside click
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: <Widget>[
          Row(
            children: [
              RaisedButton(
                color: Theme.of(context).primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  if (paymentReportController
                          .paymentReportFormKey.value.currentState
                          .validate() &&
                      paymentReportController.currPaymentType.value != null) {
                    paymentReportController
                        .paymentReportFormKey.value.currentState
                        .save();
                    Get.back();
                    Get.toNamed('paymenrReportUi');
                  }
                },
                child: Text(
                  "Ok",
                ),
              ),
              RaisedButton(
                color:
                    Get.isDarkMode ? Theme.of(context).accentColor : Colors.red,

                //  color: Theme.of(context).primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Get.isDarkMode ? null : Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Select Vendor'),
        content: SingleChildScrollView(
          child: Form(
              key: paymentReportController.paymentReportFormKey.value,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 150,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: paymentReportController.paymentTypeList.length,
                      itemBuilder: (BuildContext context, int index) => Obx(
                        () => RadioListTile<PaymentType>(
                          title: Text(paymentReportController
                              .paymentTypeList[index].paymentType),
                          value: paymentReportController.paymentTypeList[index],
                          groupValue:
                              paymentReportController.currPaymentType.value,
                          onChanged: (PaymentType value) {
                            paymentReportController.currPaymentType.value =
                                value;
                          },
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (addPaymentController.projectList != null) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          validator: (val) => val == null
                              ? "Project and Payment Type both are mandatory"
                              : null,
                          isDense: true,
                          decoration: InputDecoration(
                            /* enabledBorder: InputBorder.none that will remove the border and also the upper left 
              and right cut corner  */
                            contentPadding: EdgeInsets.only(left: 4),
                            /* 
              
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              */
                            filled: true,
                          ),
                          hint: Text('Select Project'),
                          items: paymentReportController.projectList
                              .map((projectObj) => DropdownMenuItem<Project>(
                                  value: projectObj,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: new Text(
                                            projectObj.customerRelation,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (project) {
                            paymentReportController.currProject.value = project;
                          });
                    }
                    return Text('loading...');
                  }),
                ],
              )),
        ),
      ),
    );
  }

  projectReportDialogue(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false, //enable and disable outside click
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: <Widget>[
          Row(
            children: [
              RaisedButton(
                color: Theme.of(context).primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  if (projectReportController
                      .projectReportFormKey.value.currentState
                      .validate()) {
                    projectReportController
                        .projectReportFormKey.value.currentState
                        .save();
                    Get.back();
                    Get.toNamed(
                        'projectReportUi'); //naviagate to project report ui
                  }
                },
                child: Text(
                  "Ok",
                ),
              ),
              RaisedButton(
                color:
                    Get.isDarkMode ? Theme.of(context).accentColor : Colors.red,

                //  color: Theme.of(context).primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Get.isDarkMode ? null : Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Your Projects'),
        content: SingleChildScrollView(
          child: Form(
              key: projectReportController.projectReportFormKey.value,
              child: Column(
                children: [
                  Obx(() {
                    if (projectReportController.projectList != null) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          validator: (val) =>
                              val == null ? "Please select project" : null,
                          isDense: true,
                          decoration: InputDecoration(
                            /* enabledBorder: InputBorder.none that will remove the border and also the upper left 
              and right cut corner  */
                            contentPadding: EdgeInsets.only(left: 4),
                            /* 
              
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              */
                            filled: true,
                          ),
                          hint: Text('Select Project'),
                          items: projectReportController.projectList
                              .map((projectObj) => DropdownMenuItem<Project>(
                                  value: projectObj,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: new Text(
                                            projectObj.customerRelation,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (project) {
                            projectReportController.currProject.value = project;
                          });
                    }
                    return Center(
                        child: CircularProgressIndicator(
                            //strokeWidt: 4.0,
                            ));
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
