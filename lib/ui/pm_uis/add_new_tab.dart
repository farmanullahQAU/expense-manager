import 'package:expense_manager/controllers/Admin/addLaborCategorController.dart';

import 'package:expense_manager/controllers/user_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expense_manager/controllers/select_project_controller.dart';

import '../selectProject.dart';

class AddNew extends GetWidget {
  var selectProjectController = Get.put(SelectProjectController());
  var usrController = Get.find<UsrController>();
  var addLaborCategoryController = AddLaborCategoryController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 2 : 3,
          children: [
            Obx(
              () =>
                usrController.currentUsr.value.userType == "Admin" ?
                   InkWell(
                    child: addCard(context, Colors.orange, 'Material-Category',
                        Icons.payment),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          /* if the current project is not null then user will be directed to ui */
                          ? SelectProject().showAdminSelectProjectDialog(
                              context, 'addPaymentUi', true)
                          : Get.toNamed('addPaymentUi');
                    },
                  ):
              
                 InkWell(
                    child:
                        addCard(context, Colors.pink, 'Payment', Icons.payment),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          /* if the current project is not null then user will be directed to ui */
                          ? SelectProject().showPmSelectProjectDialog(context, 'addPaymentUi',false)
                          : Get.toNamed('addPaymentUi');
                    },
                  )
              
            
            ),

            Obx(() =>
              usrController.currentUsr.value.userType == "Admin"? 
                InkWell(
                  child: addCard(
                      context, Colors.red, 'Labor-Category', Icons.account_box),
                  onTap: () {
             adminAddLaborCategoryDialog(context);
                  },
                ):
          
              InkWell(
                  child: addCard(
                      context, Colors.red, ' Account', Icons.account_box),
                  onTap: () {
                    Get.toNamed('addBankAccountUi');
                  },
                )
            
            ),
            Obx(() =>
              usrController.currentUsr.value.userType == "Admin"?
               InkWell(
                  child: addCard(context, Theme.of(context).primaryColor,
                      'Project-Manager', Icons.person_add),
                  onTap: () {
                    //  Get.toNamed('addCustomer');
                  },
                ):
            
            InkWell(
                  child: addCard(context, Theme.of(context).primaryColor,
                      'Customer', Icons.person_add),
                  onTap: () {
                    Get.toNamed('addCustomer');
                  },
                )
             
            ),


//
  Obx(() =>
            usrController.currentUsr.value.userType == "Admin"?
               InkWell(
                    child: addCard(context, Theme.of(context).primaryColor,
                        'Project-Contract', Icons.person_add),
                    onTap: () {
                      Get.toNamed('projectContractUi');
                    },
                  ):
              
              InkWell(
                    child: addCard(context, Theme.of(context).primaryColor,
                        'Vendor', Icons.people),
                    onTap: () {
                      //   Get.toNamed('addCustomer');
                    },
                  )
          ),

//

 Obx(() =>
            usrController.currentUsr.value.userType == "Admin"? 
              InkWell(
                    child: addCard(context, Colors.deepOrangeAccent, 'Picture',
                        Icons.photo),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          ?SelectProject().showAdminSelectProjectDialog(context, 'fetchImagesUi', false)
                          : Get.toNamed('fetchImagesUi');
                      //  showSelectProjectDialog(context);
                    },
                  ):
              
           InkWell(
                    child: addCard(context, Colors.deepOrangeAccent, 'Picture',
                        Icons.add_a_photo),
                    onTap: () {
                      selectProjectController.currentProject.value == null
                          ?SelectProject().showPmSelectProjectDialog(context, 'uploadPictureUi',false)
                          : Get.toNamed('uploadPictureUi');
                      //  showSelectProjectDialog(context);
                    },
                  )
             
            ),

//
            
                
                
        
          
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
                          Get.toNamed('addMaterialUi');
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
                          ? 
                          
                          
                          SelectProject().showPmSelectProjectDialog(context, 'addLaborUi',false)
                          
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

  

 

//to add labor category to the database e.g plumber etc.
  adminAddLaborCategoryDialog(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false, //enable and disable outside click
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: <Widget>[
          Row(
            children: [
              RaisedButton(
                  child: Text('Ok'),
                  color: Theme.of(context).primaryColor,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () async {
                    if (addLaborCategoryController
                        .addCategoryFormKey.value.currentState
                        .validate()) {
                      addLaborCategoryController
                          .addCategoryFormKey.value.currentState
                          .save();

                      addLaborCategoryController.addLaborCategoryToDb();
                      Get.back();
                      //  Get.toNamed(routeName); //navigate to upload picuture ui
                    }
                  }),
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
        title: Text('Add Labor Category'),
        content: SingleChildScrollView(
          child: Form(
              key: addLaborCategoryController.addCategoryFormKey.value,
              child: Column(
                children: [
                  TextFormField(
                    controller:
                        addLaborCategoryController.categoryTextCotroller.value,
                    validator: (val) =>
                        val.isEmpty ? "Plz enter Category name" : null,
                    onSaved: (val) =>
                        addLaborCategoryController.categoryString.value = val,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Labor Category',
                      filled: true,
                      contentPadding: EdgeInsets.all(4),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }






  
}
