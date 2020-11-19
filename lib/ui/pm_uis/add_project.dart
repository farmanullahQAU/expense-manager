import 'package:expense_manager/controllers/add_project_controller/add_project_controller.dart';
import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/customer_controller/customer_controller.dart';

import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/models/project_contract_model.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddProject extends GetWidget<AddProjectController> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  List<Usr> customers = new List();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              })
        ],
        //  backgroundColor: Colors.teal,
        title: Text('Add Project'),
      ),
      body: SmartRefresher(
        onRefresh: () async {
          controller.fetchData();
          if (controller.getCustomerList != null &&
              controller.getProContracts != null) {
            await Future.delayed(Duration(milliseconds: 2000));
            controller.getRefreshController.refreshCompleted();
          } else {
            await Future.delayed(Duration(milliseconds: 2000));
            controller.getRefreshController.refreshFailed();
          }
        },
        enablePullDown: true,

        //header: WaterDropHeader(),
        controller: controller.getRefreshController,

        child: Container(
          child: Form(
            key: controller.getformKey,
            child: addForm(context),
          ),
          margin: EdgeInsets.all(20),
        ),
      ),
    )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget addForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text('Add Project Details'),
          ),
          addFirstRow(context),
          addSecondRow(context),
          addThirdRow(context),
          addFourthColumn(context),
        ],
      ),
    );
  }

  Widget addFirstRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Flexible(
            child: ListTile(
                contentPadding: EdgeInsets.only(left: 4.0),
                leading: const Icon(
                  Icons.today,
                ),
                title: Text(controller.getStartDate == null
                    ? 'Start Date'
                    : '${controller.getStartDate.day}/ ${controller.getStartDate.month}/${controller.getStartDate.year}'),
                subtitle: Text('Date start'),
                onTap: () async {
                  await setStartDate(context);
                }),
          ),
        ),
        SizedBox(
          width: isLandscap(context) ? 10 : 5,
        ),
        Flexible(
          child: ListTile(
              contentPadding: EdgeInsets.only(left: 4.0),
              leading: const Icon(
                Icons.today,
              ),
              title: controller.getEndDate == null
                  ? Text('select end data')
                  : Text(
                      '${controller.getEndDate.day}/ ${controller.getEndDate.month}/${controller.getEndDate.year}'),

              // subtitle: Text('Date End'),
              onTap: () async {
                await setEndDate(context);
              }),
        ),
      ],
    );
  }

  Widget addSecondRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: ListTile(
              // tileColor: Colors.redAccent,
              contentPadding: EdgeInsets.only(left: 10.0),
              leading: const Icon(Icons.add_location),
              title: Text('Location'),
              //  subtitle: Text('Date start'),
              onTap: () async {
                await setStartDate(context);
              }),
        ),
        SizedBox(
          width: isLandscap(context) ? 10 : 5,
        ),
        Flexible(
          //  flex: context.isLandscape ? 1 : 2,

          child: Obx(() {
            if (controller.getCustomerList != null) {
              return DropdownButtonFormField(

                  //  autovalidate: true,
                  validator: (val) =>
                      val == null ? 'please select Customer' : null,
                  isDense: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                  hint: Text(' customer'),
                  items: controller.getCustomerList
                      .map((e) => DropdownMenuItem<Usr>(
                          value: e,
                          child: Column(
                            children: [
                              GestureDetector(
                                  //tab only on value to show diaglue not whole column
                                  onLongPress: context.isPortrait
                                      ? () {
                                          Get.defaultDialog(
                                            barrierDismissible: false,
                                            onCancel: () {
                                              Get.back();
                                            },
                                            confirmTextColor: Get.isDarkMode
                                                ? Theme.of(context).primaryColor
                                                : Colors.white,

                                            onConfirm: () {
                                              Get.back();
                                            },
                                            title: 'Add Payment',
                                            //payment option ui displa
                                            actions: [
                                              Text(e.address),
                                            ],
                                            radius: 10.0,
                                          );
                                        }
                                      : null,
                                  child: Text(e.address)),
                            ],
                          )))
                      .toList(),
                  onChanged: (val) {
                    controller.setCurrSelCustomer = val;
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        )
      ],
    );
  }

  Widget addThirdRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: TextFormField(
            controller: controller.estimatedCostController,
            validator: (val) => val.isEmpty ? "Plz enter estimated cost" : null,
            onSaved: (val) => controller.setEstCost = double.parse(val),
            maxLength: 9,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(

                // isDense: true,

                // enabledBorder: InputBorder.none,
                // border: InputBorder.none,

                /*  prefixIconConstraints: BoxConstraints(
                  minHeight: context.isLandscape ? 200 : 5,
                  minWidth: context.isLandscape ? 200 : 5,
                ),
                controll the input filed width and height 
                */
                contentPadding: EdgeInsets.all(4),
                filled: true,
                prefixIcon: Icon(
                  Icons.attach_money,
                ),
                labelText: 'Estimated Cost'),
          ),
        ),
        SizedBox(
          width: isLandscap(context) ? 10 : 5,
        ),
        Flexible(
          // flex: context.isLandscape ? 1 : 2,
          child: Obx(() {
            if (controller.getProContracts != null) {
              return DropdownButtonFormField(
                  validator: (val) =>
                      val == null ? "Plz select contract" : null,

                  // isDense: true,

                  decoration: InputDecoration(
                    /* enabledBorder: InputBorder.none that will remove the border and also the upper left 
                and right cut corner  */
                    contentPadding: EdgeInsets.only(left: 8),
                    /* 
                
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                */
                    filled: true,
                  ),
                  hint: Text(' Contract Type'),
                  items: controller.getProContracts
                      .map((contractObj) => DropdownMenuItem<ProjectContracts>(
                          value: contractObj,
                          child: Column(
                            children: [
                              Text(contractObj.contractName.toString()),
                            ],
                          )))
                      .toList(),
                  onChanged: (contract) {
                    controller.setCurrProjContractal = contract;
                  });
            }
            return Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'loading... ',
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget addFourthColumn(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (val) =>
              val.isNullOrBlank ? "Plz enter customer relation details" : null,

          onChanged: (value) {
            controller.setRelationString = value;

            print(controller.getRelationString);
          },
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 12,
          maxLength: 200,
          // expands: true,
          textInputAction: TextInputAction.newline,
          controller: controller.remarksController,
          decoration: InputDecoration(
              suffixIcon: Obx(() =>
                  controller.getRelationString?.length == null ||
                          controller.getRelationString == ''
                      ? Container(width: 0.0, height: 0.0)
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            controller.remarksController.clear();
                          })),
              contentPadding: EdgeInsets.all(4),

              //  contentPadding: EdgeInsets.all(10),
              filled: true,
              prefixIcon: Icon(Icons.add_business),
              labelText: 'Customer Relation'),
        ),
        SizedBox(
          width: isLandscap(context) ? 10 : 5,
        ),
        TextFormField(
          validator: (val) =>
              val.isNullOrBlank ? "Plz give customer remarks" : null,

          onChanged: (value) {
            controller.setRemarksString = value;
          },
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          maxLength: 200,

          // expands: true,
          textInputAction: TextInputAction.newline,

          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(4),

              //  contentPadding: EdgeInsets.all(10),
              filled: true,
              prefixIcon: Icon(Icons.comment),
              suffixIcon: Obx(() =>
                  controller.getRemarkString?.length == null ||
                          controller.getRemarkString == ''
                      ? Container(width: 0.0, height: 0.0)
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            controller.remarksController.clear();
                          })),
              labelText: 'Customer Remarks'),
        ),
        Container(
            width: context.width - 0.2,
            child: FlatButton(
                textColor: Get.isDarkMode ? null : Colors.white,
                child: Text('Add Project'),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (controller.getformKey.currentState.validate()) {
                    controller.getformKey.currentState.save();
                    CircularProgressIndicator();

                    controller.addProject(
                        /*get current logged in Pm who added who is goint to add this project*/
                        projectManager:
                            Get.find<UsrController>().getCurrentUser,
                        customer: controller.getCurrSelCustomer,
                        projectContract: controller.getcurrProjContract,
                        custRelationText: controller.getRelationString,
                        custRemarksString: controller.getRemarkString,
                        starDate: controller.getStartDate,
                        endDate: controller.getEndDate,
                        estimatedCost: controller.getEstCost);
                  }
                }))
      ],
    );
  }

  bool isLandscap(BuildContext context) {
    return context.isLandscape;
  }

  setStartDate(BuildContext context) async {
    DateTime pikeDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.input,
        context: context,
        initialDate: controller.getStartDate ?? DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (pikeDate != null) controller.setStarDate(pikeDate);
  }

  setEndDate(BuildContext context) async {
    DateTime pikeDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.input,
        context: context,
        initialDate: controller.getEndDate ??
            DateTime
                .now(), //if selected time is null set current data as initial
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (pikeDate != null) controller.setEndDate(pikeDate);
  }
}
