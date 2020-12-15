import 'package:expense_manager/controllers/uploadImages/upload_images_controller.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/ui/Reports/payment_report.dart';
import 'package:expense_manager/ui/Labor/add_labor.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expense_manager/controllers/select_project_controller.dart';

class AddNew extends GetWidget {
  var selectProjectController = Get.put(SelectProjectController());
  var usrController = Get.find<UsrController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 2 : 3,
          children: [
            Obx(() => usrController.currentUsr.value.userType == "Admin"
                ? InkWell(
                    child: addCard(context, Colors.orange, 'Material-Category',
                        Icons.payment),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          /* if the current project is not null then user will be directed to ui */
                          ? showSelectProjectDialog(context, '/addPaymentUi')
                          : Get.toNamed('addPaymentUi');
                    },
                  )
                : InkWell(
                    child:
                        addCard(context, Colors.pink, 'Payment', Icons.payment),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          /* if the current project is not null then user will be directed to ui */
                          ? showSelectProjectDialog(context, '/addPaymentUi')
                          : Get.toNamed('addPaymentUi');
                    },
                  )),
            Obx(
              () => usrController.currentUsr.value.userType == "Admin"
                  ? InkWell(
                      child: addCard(context, Colors.red, 'Labor-Category',
                          Icons.account_box),
                      onTap: () {
                        //  Get.toNamed('addBankAccountUi');
                      },
                    )
                  : InkWell(
                      child: addCard(
                          context, Colors.red, ' Account', Icons.account_box),
                      onTap: () {
                        Get.toNamed('addBankAccountUi');
                      },
                    ),
            ),
            Obx(
              () => usrController.currentUsr.value.userType == "Admin"
                  ? InkWell(
                      child: addCard(context, Theme.of(context).primaryColor,
                          'Project-Manager', Icons.person_add),
                      onTap: () {
                        //  Get.toNamed('addCustomer');
                      },
                    )
                  : InkWell(
                      child: addCard(context, Theme.of(context).primaryColor,
                          'Customer', Icons.person_add),
                      onTap: () {
                        Get.toNamed('addCustomer');
                      },
                    ),
            ),
            Obx(() => usrController.currentUsr.value.userType == "Admin"
                ? InkWell(
                    child: addCard(context, Theme.of(context).primaryColor,
                        'Project-Contract', Icons.person_add),
                    onTap: () {
                      Get.toNamed('projectContractUi');
                    },
                  )
                : InkWell(
                    child: addCard(context, Theme.of(context).primaryColor,
                        'Vendor', Icons.people),
                    onTap: () {
                      //   Get.toNamed('addCustomer');
                    },
                  )),
            Obx(() => usrController.currentUsr.value.userType == "Admin"
                ? InkWell(
                    child: addCard(context, Colors.deepOrangeAccent, 'Picture',
                        Icons.photo),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          ? showSelectProjectDialog(context, 'uploadPictureUi')
                          : Get.toNamed('uploadPictureUi');
                      //  showSelectProjectDialog(context);
                    },
                  )
                : InkWell(
                    child: addCard(context, Colors.deepOrangeAccent, 'Picture',
                        Icons.add_a_photo),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          ? showSelectProjectDialog(context, 'uploadPictureUi')
                          : Get.toNamed('uploadPictureUi');
                      //  showSelectProjectDialog(context);
                    },
                  )),
            // InkWell(
            //   child: addCard(context, Colors.deepOrangeAccent, 'Picture',
            //       Icons.add_a_photo),
            //   onTap: () {
            //     selectProjectController.currentProject.value == null
            //         ? showSelectProjectDialog(context, 'uploadPictureUi')
            //         : Get.toNamed('uploadPictureUi');
            //     //  showSelectProjectDialog(context);
            //   },
            // ),
            Obx(
              () => usrController.currentUsr.value.userType == "Admin"
                  ? InkWell(
                      onTap: () {
                        //    Get.to(PaymentReport());
                      },
                      child: addCard(
                        context,
                        Colors.blueAccent,
                        'Message',
                        Icons.message,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        //      Get.to(PaymentReport());
                      },
                      child: addCard(
                        context,
                        Colors.amber,
                        'Material',
                        Icons.shop_two,
                      ),
                    ),
            ),
//just to to aligin the last labor card to center
            Obx(
              () => usrController.currentUsr.value.userType == "Admin"
                  ? Container(width: 0.0, height: 0.0)
                  : InkWell(),
            ),
            Obx(() => usrController.currentUsr.value.userType == "Admin"
                ? Container(width: 0.0, height: 0.0)
                : InkWell(
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          /* if the current project is not null then user will be directed to ui */
                          ? showSelectProjectDialog(context, '/addLaborUi')
                          : Get.toNamed('addLaborUi');
                    },
                    child: addCard(
                      context,
                      Colors.blue,
                      'Labor',
                      Icons.person_add,
                    ),
                  )),
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
              size: context.isLandscape ? 20 : 40,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.lobsterTwo(
              textStyle: TextStyle(color: Colors.blue, letterSpacing: .2),
            ),
          )
        ],
      )),
    );
  }

  showSelectProjectDialog(BuildContext context, String routeName) {
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
                  if (selectProjectController
                      .selectProjectFormKey.value.currentState
                      .validate()) {
                    selectProjectController
                        .selectProjectFormKey.value.currentState
                        .save();
                    Get.back();
                    Get.toNamed(routeName); //navigate to upload picuture ui
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
        title: Text('Projects Pannel'),
        content: SingleChildScrollView(
          child: Form(
              key: selectProjectController.selectProjectFormKey.value,
              child: Column(
                children: [
                  Obx(() {
                    if (selectProjectController.projectList != null) {
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
                          items: selectProjectController.projectList
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
                            selectProjectController.currentProject.value =
                                project;
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
}
