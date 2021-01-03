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
      body:

       
        
        
          Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [

                     
                  projectReport(context, selectProjectController.currentProject.value)






                     
                       
                    ],
                  )),
                ),
              ),
        
      
      floatingActionButton: Obx(
        () => selectProjectController.currentProject.value.id==null
            ? Container(width: 0.0, height: 0.0)
            : FloatingActionButton(
                child: Icon(Icons.picture_as_pdf),
                onPressed: () {
                 
                  controller.createPdf(selectProjectController.currentProject.value);
                },
              ),
      ),
    );
  }

  
  Widget projectReport(BuildContext context, Project project ) {
    return Column(
      children: [
        DataTable(
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
         rows:[    DataRow(cells: [
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


                    

                  ])], 
             

        )
      ]
    );
  }
  

 
/*
  Widget projectReport(BuildContext context, RxList<Project> respectiveUsrProjecList ) {
    return Column(
      children: [
        DataTable(
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


                    

                  ]))
              .toList(),
        ),

        Text('Current Expenses'),

      ],
    );
  }
  */

  

}
