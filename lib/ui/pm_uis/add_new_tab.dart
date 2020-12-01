import 'package:expense_manager/controllers/uploadImages/upload_images_controller.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/ui/Reports/payment_report.dart';
import 'package:expense_manager/ui/admin_ui/login1.dart';
import 'package:expense_manager/ui/pm_uis/bankAccounts/add_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addPayment/add_payment.dart';

class AddNew extends GetWidget {
  var uploadPictureController = Get.put(UploadImagesController());
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 2 : 3,
          children: [
            InkWell(
              child: addCard(context, Colors.green, 'Payment', Icons.payment),
              onTap: () {
                // Get.defaultDialog(
                //   barrierDismissible: true,
                //   onCancel: () {},
                //   confirmTextColor: Get.isDarkMode
                //       ? Theme.of(context).primaryColor
                //       : Colors.white,

                //   onConfirm: () {},
                //   title: 'Add Payment',
                //   //payment option ui displa
                //   actions: [
                //     AddPayment(),
                //   ],
                //   radius: 10.0,
                // );
                Get.toNamed('addPaymentUi');
              },
            ),
            InkWell(
              child:
                  addCard(context, Colors.red, ' Account', Icons.account_box),
              onTap: () {
                Get.toNamed('addBankAccountUi');
              },
            ),
            InkWell(
              child: addCard(context, Theme.of(context).primaryColor,
                  'Customer', Icons.person_add),
              onTap: () {
                Get.toNamed('addCustomer');
              },
            ),
            addCard(context, Theme.of(context).primaryColor, 'Vendor',
                Icons.people),
            InkWell(
              child: addCard(context, Colors.deepOrangeAccent, 'Picture',
                  Icons.add_a_photo),
              onTap: () {
                showSelectProjectDialog(context);
              },
            ),
            InkWell(
              onTap: () {
                Get.to(PaymentReport());
              },
              child: addCard(
                context,
                Colors.amber,
                'Material',
                Icons.shop_two,
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
          Text(title)
        ],
      )),
    );
  }

  showSelectProjectDialog(BuildContext context) {
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
                  if (uploadPictureController
                          .uploadPicFormKey.value.currentState
                          .validate() &&
                      uploadPictureController.currProject.value != null) {
                    uploadPictureController.uploadPicFormKey.value.currentState
                        .save();
                    Get.back();
                    Get.toNamed(
                        'uploadPictureUi'); //navigate to upload picuture ui
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
              key: uploadPictureController.uploadPicFormKey.value,
              child: Column(
                children: [
                  Obx(() {
                    if (uploadPictureController.projectList != null) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          validator: (val) => val == null
                              ? "Please select project to upload picture"
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
                          items: uploadPictureController.projectList
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
                            uploadPictureController.currProject.value = project;
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
