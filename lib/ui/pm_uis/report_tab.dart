import 'package:expense_manager/controllers/ReportsController/payment_report_controller.dart';
import 'package:expense_manager/controllers/ReportsController/project_report_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/ui/selectProject.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Reports extends GetWidget {
  // var paymentReportController = Get.find<PaymentReportController>();
  var projectReportController = Get.find<ProjectReportController>();

  var selectedProjCont = Get.find<SelectProjectController>();
  final usrController=Get.find<UsrController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 2 : 3,
          children: [

            Obx((){

              if(usrController.currentUsr.value.userType=='Admin')
              {
return  InkWell(
              child: addCard(
                  context, Colors.green, 'Project Report', Icons.person),
              onTap: () {
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showAdminSelectProjectDialog(context,
                         "projectReportUi")
                    : Get.toNamed('projectReportUi');
              },
            
            );
              }
            else  if(usrController.currentUsr.value.userType=='Project manager')
            {
              return  InkWell(
              child: addCard(
                  context, Colors.green, 'Project Report', Icons.person),
              onTap: () {
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showAdminSelectProjectDialog(context,
                         "projectReportUi")
                    : Get.toNamed('projectReportUi');
              },
            
            );

            }
            else{

              return  InkWell(
              child: addCard(
                  context, Colors.green, 'Project Report', Icons.person),
              onTap: () {
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showCustomerSelectProjectDialog(context,
                         "projectReportUi")
                    : Get.toNamed('projectReportUi');
              },
            
            );
            }
            
            }
            //one item completed for three users
            
        
            
            ),




Obx((){
              if(usrController.currentUsr.value.userType=='Admin')
              {
                return InkWell(
              child: addCard(context, Colors.red, ' Payment Report ',
                  Icons.account_balance_wallet),
              onTap: () {
                // selectedProjCont.currentProject.value == null
                //     ? showSelectProjectDialog(context, routeName: "")
                //     : selectPaymentTypeDialog(context);
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showAdminSelectProjectDialog(context,
                        "paymentReportUi")
                    : Get.toNamed('paymentReportUi');
              },
            );

              }
              else 
              if(usrController.currentUsr.value.userType=='Project manager')
              {
                  return InkWell(
              child: addCard(context, Colors.red, ' Payment Report ',
                  Icons.account_balance_wallet),
              onTap: () {
                // selectedProjCont.currentProject.value == null
                //     ? showSelectProjectDialog(context, routeName: "")
                //     : selectPaymentTypeDialog(context);
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showPmSelectProjectDialog(context,
                        "paymentReportUi")
                    : Get.toNamed('paymentReportUi');
              },
            );


              }
              else{

                  return InkWell(
              child: addCard(context, Colors.red, ' Payment Report ',
                  Icons.account_balance_wallet),
              onTap: () {
                // selectedProjCont.currentProject.value == null
                //     ? showSelectProjectDialog(context, routeName: "")
                //     : selectPaymentTypeDialog(context);
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showCustomerSelectProjectDialog(context,
                        "paymentReportUi")
                    : Get.toNamed('paymentReportUi');
              },
            );


              }




}),

Obx((){
              if(usrController.currentUsr.value.userType=='Admin')
              {
             return    InkWell(
                  onTap: (){

                       selectedProjCont.currentProject.value == null
                    ? SelectProject().showAdminSelectProjectDialog(context,
                        "")
                    : Get.toNamed('paymentReportUi');


                  },

                  child: addCard(context, Colors.deepOrangeAccent, 'Material Report',
                Icons.subway),
                );
                   
                
              }
              else 
              if(usrController.currentUsr.value.userType=='Project manager')
              {

                  return    InkWell(
                  onTap: (){

                       selectedProjCont.currentProject.value == null
                    ? SelectProject().showPmSelectProjectDialog(context,
                        "")

                        //naviagate to material report
                    : Get.toNamed('paymentReportUi');


                  },

                  child: addCard(context, Colors.deepOrangeAccent, 'Material Report',
                Icons.subway),
                );

              }

              //beacuse customer has no ui for material 
              else return Container(width: 0.0,height:0.0,);



}),
       Obx((){

              if(usrController.currentUsr.value.userType=='Admin'
              )
              {
                return  InkWell(
              onTap: () {
  selectedProjCont.currentProject.value == null
                    ? SelectProject().showAdminSelectProjectDialog(context,
                        "")
                        //respective ui
                    : Get.toNamed('paymentReportUi');



              },
              child: addCard(
                context,
                Colors.amber,
                'Vendor Report',
                Icons.polymer,
              ),
            );


              }
              else 
              if(usrController.currentUsr.value.userType=='Project manager')
              {
                  return  InkWell(
              onTap: () {



                  selectedProjCont.currentProject.value == null
                    ? SelectProject().showPmSelectProjectDialog(context,
                        "")
                    : Get.toNamed('paymentReportUi');
              },
              child: addCard(
                context,
                Colors.amber,
                'Vendor Report',
                Icons.polymer,
              ),
            );

              }
              else{
                return Container(width:0.0, height:0.0);
              }

         
       }),    
           
         Obx((){
              if(usrController.currentUsr.value.userType=='Admin')
              {

                return   InkWell(
              onTap: () {
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showAdminSelectProjectDialog(context,
                        "laborReportUi")
                    : Get.toNamed('laborReportUi');
              },
              child: addCard(
                context,
                Colors.blue,
                'Labor Report',
                Icons.person,
              ),
            );


              }
              else 
              if(usrController.currentUsr.value.userType=='Project manager')
              {
                 return   InkWell(
              onTap: () {
                selectedProjCont.currentProject.value == null
                    ? SelectProject().showPmSelectProjectDialog(context,
                        "laborReportUi")
                    : Get.toNamed('laborReportUi');
              },
              child: addCard(
                context,
                Colors.blue,
                'Labor Report',
                Icons.person,
              ),
            );

              }
              else{
                return Container(width: 0.0,height: 0.0,);
              }




         })
           
          
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

  /* 
 //payment type with listTile
 
 
 selectPaymentTypeDialog(BuildContext context) {
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
        title: Text('Select Payment'),
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
                ],
              )),
        ),
      ),
    );
  }
  */

 
}
