import 'dart:io';

import 'package:expense_manager/controllers/ReportsController/labor_report_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';
import 'package:expense_manager/controllers/ReportsController/project_report_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';
import 'package:expense_manager/models/project_model.dart';

class ProjectReport extends GetWidget<ProjectReportController> {
  var usrController=Get.find<UsrController>();
  var selectProjectController=Get.find<SelectProjectController>();
  // savePdf() async {
  //   final file = File("example.pdf");
  //   await file.writeAsBytes(pdf.save());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // Obx(() => controller.currFilterOption.value == "Contract-Base"
          //     ? IconButton(
          //         icon: Icon(Icons.add),
          //         onPressed: () {},
          //       )
          //     : Container(width: 0.0, height: 0.0)),
          // PopupMenuButton(
          //   onSelected: (val) {
          //     controller.currFilterOption.value = val;
          //   },
          //   itemBuilder: (BuildContext context) {
          //     return controller.filterOption.map((e) {
          //       return PopupMenuItem(
          //         value: e,
          //         child: ListTile(
          //           title: Text(e),
          //         ),
          //       );
          //     }).toList();
          //   },
          // ),
        ],
        title: Text('Project Report'),
      ),
      body: Obx(
        () {

          if(   
             (usrController.currentUsr.value.userType == "Admin" &&
                selectProjectController.projectListAdmin == null)||(usrController.currentUsr.value.userType == "Project manager" &&
                selectProjectController.projectListPm== null)||(usrController.currentUsr.value.userType == "Customer" &&
                selectProjectController.projectListCustomer == null)
          )
          {
            print('no data found');
  return 
            
             Center(child: CircularProgressIndicator());

          }
        
             else
        
           return   Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      if(usrController.currentUsr.value.userType=="Admin")

                     
                        projectReport(context, selectProjectController.projectListAdmin)
                        else if(usrController.currentUsr.value.userType=="Project manager")
                        projectReport(context, selectProjectController.projectListPm)
                        else if(usrController.currentUsr.value.userType=="Customer")
                        projectReport(context, selectProjectController.projectListCustomer)
                        else Center(child: Container(child: Text('No project found'),))


                     
                       
                    ],
                  )),
                ),
              );
        }
      ),
      floatingActionButton: Obx(
        () => controller.allLabors.isEmpty
            ? Container(width: 0.0, height: 0.0)
            : FloatingActionButton(
                child: Icon(Icons.picture_as_pdf),
                onPressed: () {
                  controller.createPdf();
                  controller.createPdf();
                },
              ),
      ),
    );
  }

 

  DataTable projectReport(BuildContext context, RxList<Project> respectiveUsrProjecList ) {
    return DataTable(
      headingRowColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Theme.of(context).colorScheme.primary.withOpacity(0.08);
        return Get.isDarkMode
            ? Theme.of(context).primaryColor
            : Colors.grey[200]; // Use the default value.
      }),
      columns: [
        DataColumn(label: Text('Id'), tooltip: 'Project ID.'),
        DataColumn(label: Text('Start'), tooltip: 'Date Start'),
        DataColumn(label: Text('Total-Estimate'), tooltip: 'Estimated Cost'),
        DataColumn(label: Text('Customer'), tooltip: 'Project Customer'),
        DataColumn(label: Text('Phone'), tooltip: 'Customer Phone'),
        DataColumn(label: Text('Wagers-Wroked'), tooltip: 'Total Labors'),
        DataColumn(label: Text('Total-Wage'), tooltip: 'Total Labors'),


        DataColumn(label: Text('Contractors'), tooltip: 'Customer-Phone'),
        DataColumn(label: Text('Total-Contract amount'), tooltip: 'Customer-Phone'),

        DataColumn(label: Text('C-Expenses'), tooltip: 'Current Expenses'),
        DataColumn(label: Text('End'), tooltip: 'Date End'),



      //  DataColumn(label: Text('Amount'), tooltip: 'Wage Amount'),
//DataColumn(label: Text('Days-Worked'), tooltip: 'Total Working days'),
       // DataColumn(label: Text('Amount Payable'), tooltip: 'Total Salary'),
       // DataColumn(label: Text('Amount Status'), tooltip: 'Total Salary'),
      ],
      rows:

       respectiveUsrProjecList
          .map((project) => DataRow(cells: [
                // DataCell((data.verified)
                //     ? Icon(
                //         Icons.verified_user,
                //         color: Colors.green,
                //       )
                //     : Icon(Icons.cancel, color: Colors.red)),
                // I want to display a green color icon when user is verified and red when unverified
                DataCell(Text(project.id.substring(0,4))),
                DataCell(Text(project.starDate)),
                DataCell(Text(project.estimatedCost)),
                DataCell(Text(project.customer.name)),


                DataCell(Text(project.customer.phone)),

                DataCell(Text('total wagers')),
                DataCell(Text(project.totalWageAmount.toString())),

                DataCell(Text('total contractos')),
                DataCell(Text(project.totalContractAmount.toString())),

                DataCell(Text(project.currExpenses)),
                DataCell(Text(project.endDate)),


                


//                 DataCell(
//                   Row(
//                     children: [
//                       FloatingActionButton(
//                           heroTag: data.reference.id,
//                           tooltip: "Add Working Day",
//                           backgroundColor: Get.isDarkMode
//                               ? Theme.of(context).primaryColor
//                               : Colors.green,
//                           onPressed: () async {
//                             await data.reference
//                                 .update({'daysWorked': FieldValue.increment(1)})
//                                 .then((value) => Fluttertoast.showToast(
//                                     backgroundColor: Colors.green,
//                                     msg: "Working day Addedd Successfully"))
//                                 .catchError((err) => Fluttertoast.showToast(
//                                     backgroundColor: Colors.red,
//                                     msg: err.toString()));
// //update total wage in database
//                             await data.reference.update({
//                               'totalWage':
//                                   (data.amount * data.daysWorked).toString()
//                             }).then((value) {
//                               controller.totalWageAmount.value +=
//                                   double.parse(data.totalWage);
//                               //to add this total wage to current selected project

//                               controller.updateProjectTotalWage();
//                             }
                            
//                             );
//                           },
//                           child: Icon(Icons.add)),
//                       Text(data.daysWorked.toString())
//                     ],
//                   ),
//                 ),
//                 DataCell(Text(data.totalWage)),
//                 DataCell(
//                   data.paymentStatus == false
//                       ? InkWell(
//                           onTap: () async {
//                             data.reference.update({'paymentStatus': true}).then(
//                                 (value) {
//                                 return   Fluttertoast.showToast(
//                                     backgroundColor: Colors.black,
//                                     msg: "Submitted ");

//                                 });
//                           },
//                           child: Row(
//                             children: [
//                               data.paymentStatus == true
//                                   ? Text('Paid')
//                                   : Text('Not Payed'),
//                               Icon(Icons.check_box_outline_blank_rounded)
//                             ],
//                           ),
//                         )
//                       : InkWell(
//                           onTap: () async {
//                             data.reference
//                                 .update({'paymentStatus': false}).then(
//                                     (value) {



//                                      return  Fluttertoast.showToast(
//                                         backgroundColor: Colors.black,
//                                         msg: "Request Submitted ");
//                                     });
//                           },
//                           child: Row(
//                             children: [
//                               data.paymentStatus == true
//                                   ? Text('Paid')
//                                   : Text('Not Payed'),
//                               Icon(Icons.check_box_outlined)
//                             ],
//                           ),
//                         ),
//                 ),
              ]))
          .toList(),
    );
  }

  

 /* 
 //add new contract to the taped labor
 
 showContractDialog(BuildContext context, DocumentReference reference) {
    return showDialog(
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
                onPressed: () async {
                  if (controller.contractDetailsFormKey.value.currentState
                      .validate()) {
                    controller.contractDetailsFormKey.value.currentState.save();
                    await controller.addLaborContract(reference);

                    controller.contractDetailsTextController.value.clear();
                    controller.contractNameTextController.value.clear();
                    Get.back();
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
                  controller.contract.value = null;
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
        title: Text('Contract details'),
        content: SingleChildScrollView(
          child: Form(
              key: controller.contractDetailsFormKey.value,
              child: Container(
                width: context.width * 0.6,
                height: context.height * 0.5,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.contractNameTextController.value,
                      validator: (val) =>
                          val.isEmpty ? "Please enter contract name" : null,

                      /* set contract object value when user clicks of ok */
                      /*set contract name*/
                      onSaved: (contractName) =>
                          controller.contractName.value = contractName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          filled: true,
                          prefixIcon: Icon(Icons.perm_identity),
                          labelText: 'Contract-Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: controller.amountTextEditingController,
                        validator: (val) =>
                            val.isEmpty ? "Plz enter contract amount" : null,
                        onSaved: (val) =>
                            controller.amount.value = double.parse(val),
                        maxLength: 9,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.attach_money,
                            ),
                            labelText: 'Contract-Amount'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller:
                            controller.contractDetailsTextController.value,
                        validator: (val) => val.isEmpty
                            ? "Please enter contract details"
                            : null,
                        onSaved: (contractDetails) =>
                            /* set description */
                            controller.contractDesc.value = contractDetails,
                        maxLength: 100,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.note,
                            ),
                            labelText: 'Contract-details'),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
  */
}
