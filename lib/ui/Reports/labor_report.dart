import 'dart:io';

import 'package:expense_manager/controllers/ReportsController/labor_report_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expense_manager/controllers/user_controller.dart';

class LabotReport extends GetWidget<LaborReportController> {
  var usrController=Get.find<UsrController>();
  // savePdf() async {
  //   final file = File("example.pdf");
  //   await file.writeAsBytes(pdf.save());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Obx(() => controller.currFilterOption.value == "Contract-Base"
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                )
              : Container(width: 0.0, height: 0.0)),
          PopupMenuButton(
            onSelected: (val) {
              controller.currFilterOption.value = val;
            },
            itemBuilder: (BuildContext context) {
              return controller.filterOption.map((e) {
                return PopupMenuItem(
                  value: e,
                  child: ListTile(
                    title: Text(e),
                  ),
                );
              }).toList();
            },
          ),
        ],
        title: Text('Labor-Report'),
      ),
      body: Obx(
        //if no filter is selected and all labors are null
        () => controller.currFilterOption.value == "" &&
                controller.allLabors == null
            ? Center(child: CircularProgressIndicator())
            : Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      if (controller.currFilterOption.value ==
                              "Daily-Wage-Base" &&
                          controller.allWagers != null)
                        dailyWagersReport(context)
                      else if (controller.currFilterOption.value ==
                              "Contract-Base" &&
                          controller.allContractors != null)
                        contractorsReport(context)
                      else if (controller.currFilterOption.value == "" &&
                          controller.allLabors != null)
                        allLaborReport(context)
                      else
                        Center(child: CircularProgressIndicator()),
                    ],
                  )),
                ),
              ),
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

  DataTable allLaborReport(BuildContext context) {
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
        DataColumn(label: Text('Name'), tooltip: 'Labor Name.'),
        DataColumn(label: Text('Phone'), tooltip: 'Labor Phone number'),
        DataColumn(label: Text('Address'), tooltip: 'Labor Address'),
        DataColumn(label: Text('Type'), tooltip: 'Labor Type'),
        DataColumn(label: Text('Amount'), tooltip: 'Contract/Wage Amount '),
        DataColumn(label: Text('Payment-Type'), tooltip: 'Payment Type '),
      ],
      rows: controller.allLabors
          .map((data) => DataRow(cells: [
                // DataCell((data.verified)
                //     ? Icon(
                //         Icons.verified_user,
                //         color: Colors.green,
                //       )
                //     : Icon(Icons.cancel, color: Colors.red)),
                // I want to display a green color icon when user is verified and red when unverified
                DataCell(Text(data.name)),
                DataCell(Text(data.phone)),
                DataCell(Text(data.address)),

                DataCell(Text(data.laborType)),
                DataCell(Text(data.amount.toString())),
                DataCell(Text(data.paymentType)),
              ]))
          .toList(),
    );
  }

  DataTable dailyWagersReport(BuildContext context) {
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
        DataColumn(label: Text('Name'), tooltip: 'Labor Name.'),
        DataColumn(label: Text('Phone'), tooltip: 'Labor Phone number'),
        DataColumn(label: Text('Address'), tooltip: 'Labor Address'),
        DataColumn(label: Text('Type'), tooltip: 'Labor Type'),
        DataColumn(label: Text('Amount'), tooltip: 'Wage Amount'),
        DataColumn(label: Text('Days-Worked'), tooltip: 'Total Working days'),
        DataColumn(label: Text('Amount Payable'), tooltip: 'Total Salary'),
        DataColumn(label: Text('Amount Status'), tooltip: 'Total Salary'),
      ],
      rows: controller.allWagers
          .map((data) => DataRow(cells: [
                // DataCell((data.verified)
                //     ? Icon(
                //         Icons.verified_user,
                //         color: Colors.green,
                //       )
                //     : Icon(Icons.cancel, color: Colors.red)),
                // I want to display a green color icon when user is verified and red when unverified
                DataCell(Text(data.name)),
                DataCell(Text(data.phone)),
                DataCell(Text(data.address)),

                DataCell(Text(data.laborType)),

                DataCell(Text(data.amount.toString())),

                DataCell(
                  Row(
                    children: [

                      //admin can't add working day
                      usrController.currentUsr.value.userType=="Customer"||usrController.
                      currentUsr.value.userType=="Admin"?Container(width: 0.0,height: 0.0,):
                      FloatingActionButton(
                      child: Icon(Icons.add),
                          heroTag: data.reference.id,
                          tooltip: "Add Working Day",
                          backgroundColor: Get.isDarkMode
                              ? Theme.of(context).primaryColor
                              : Colors.green,
                          onPressed: () async {
                            await data.reference
                                .update({'daysWorked': FieldValue.increment(1),
                                })

                                
                                .catchError((err) => Fluttertoast.showToast(
                                    backgroundColor: Colors.red,
                                    msg: err.toString()));
                            
                             
                          }),

                          //show amount payable in ui no in database
                      Text(data.daysWorked.toString())
                    ],
                  ),
                ),
                DataCell(Text((data.daysWorked*data.amount).toString())),
            
                DataCell(
                  

                  Row(
                    children: [
                     
                      
                      data.daysWorked!=0?
                      data.paymentStatus == false
                          ? InkWell(
                              onTap: () async {
                                data.reference.update({'paymentStatus': true}).then(
                                    (value) {
                                      controller.totalWagesAmount.value +=
                                      data.daysWorked*data.amount;
                                      controller.updateProjectTotalWage();
                                   

                                    }
                                    
                                    );
                              },
                              child: Row(
                                children: [
                                  data.paymentStatus == true
                                      ? Text('Paid')
                                      : Text('Not Payed'),
                                  Icon(Icons.check_box_outline_blank_rounded)
                                ],
                              ),
                            )
                          : InkWell(

                              onTap: usrController.currentUsr.value.userType=="Admin"||usrController.currentUsr.value.userType=="Customer"?null:
                              () async {
                                data.reference
                                    .update({'paymentStatus': false}).then(
                                        (value) {
                                          //fix it
                                           controller.totalWagesAmount.value -=data.daysWorked*data.amount;
                                      controller.updateProjectTotalWage();



                                        
                                        });
                              },
                              child: Row(
                                children: [
                                  data.paymentStatus == true
                                      ? Text('Paid')
                                      : Text('Not Payed'),
                                  Icon(Icons.check_box_outlined)
                                ],
                              ),
                            ):Text('No-Record'),
                    ],
                  ),
                ),
              ]))
          .toList(),
    );
  }

  DataTable contractorsReport(BuildContext context) {
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
        DataColumn(label: Text('Name'), tooltip: 'Labor Name.'),
        DataColumn(label: Text('Phone'), tooltip: 'Labor Phone number'),
        DataColumn(label: Text('Address'), tooltip: 'Labor Address'),
        DataColumn(label: Text('Type'), tooltip: 'Labor Type'),
        DataColumn(label: Text('Payment-Type'), tooltip: 'Payment Type'),

        DataColumn(label: Text('Contract'), tooltip: 'Contract Name'),

        DataColumn(label: Text('C-Amount'), tooltip: ' Contract Amount'),
        DataColumn(label: Text('Status'), tooltip: 'Payment Status'),

        


      ],
      rows: controller.allContractors.map((data) {
        return DataRow(cells: [
          // DataCell((data.verified)
          //     ? Icon(
          //         Icons.verified_user,
          //         color: Colors.green,
          //       )
          //     : Icon(Icons.cancel, color: Colors.red)),
          // I want to display a green color icon when user is verified and red when unverified
          DataCell(Text(data.name)),
          DataCell(Text(data.phone)),
          DataCell(Text(data.address)),

          DataCell(Text(data.laborType)),
            DataCell(
            Text(data.paymentType.toString()),
            
            
          ),
          DataCell(Text(data.contract.contractName)),

          DataCell(Text(data.amount.toString())),
            DataCell(
                  data.paymentStatus == false
                      ? InkWell(
                          onTap: () async {
                            data.reference.update({'paymentStatus': true}).then(
                                (value)async {

                                  
                                   controller.totalContractsAmounts.value +=
                                   //contract amount 
                                  data.amount;  
                            //  controller.currExpenses.value+=controller.totalWageAmount.value;

                                await  controller.updateProjectTotalContractAmount();
                              await  controller.updateCurrExpense();
                                

                                 return Fluttertoast.showToast(
                                    backgroundColor: Colors.black,
                                    msg: "Submitted ");

                                   

                                    



                                } );
                          },
                          child: Row(
                            children: [
                              data.paymentStatus == true
                                  ? Text('Paid')
                                  : Text('Not Payed'),
                              Icon(Icons.check_box_outline_blank_rounded)
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: ()  {
                            data.reference
                                .update({'paymentStatus': false}).then(
                                    (value)async{

/*when the user uncheck  C-amount status then the total totalContractsAmounts 
will be decrement by that amount*/
 controller.totalContractsAmounts.value-=data.amount;

                                   //contract amount 
                                  
                                 await controller.updateProjectTotalContractAmount();
                              await  controller.updateCurrExpense();

                                    return  Fluttertoast.showToast(
                                        backgroundColor: Colors.black,
                                        msg: "Request Submitted ");
                                    });
                          },
                          child: Row(
                            children: [
                              data.paymentStatus == true
                                  ? Text('Paid')
                                  : Text('Not Payed'),
                              Icon(Icons.check_box_outlined)
                            ],
                          ),
                        ),
                ),

        
          
          // DataCell(Text(data.paymentType), onTap: () {
          //   Get.defaultDialog(
          //       title: 'Contracts',
          //       content: Container(
          //         width: context.width * 0.9,
          //         height: context.height * 0.9,
          //         child: ListView.builder(
          //             itemCount: data.contract.length,
          //             itemBuilder: (context, index) =>
          //                 Text(data.contract[index].contractName)),
          //       ));
          // })
        ]);
      }).toList(),
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
