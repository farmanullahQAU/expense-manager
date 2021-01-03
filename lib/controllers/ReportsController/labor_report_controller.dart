import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:expense_manager/models/labor_model.dart';
import 'package:expense_manager/controllers/ReportsController/pdf_viewer_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';

class LaborReportController extends GetxController {

 //  final documentReference=Rx<DocumentReference>();
  var selectProjectController = Get.find<SelectProjectController>();
  var pdfViewrController = Get.find<PdfViewrController>();
  var usrController=Get.find<UsrController>();

  var isLoading = true.obs;
  var document = PDFDocument(); //to view pdf
  var pdf = pw.Document(); //create pdf
  var savedLoc = RxString();

  var allLabors = List<Labor>().obs;
  var allWagers = List<Labor>().obs;
  var allContractors = List<Labor>().obs;
  var filterOption = ["Daily-Wage-Base", "Contract-Base"].obs;
  var currFilterOption = "".obs;
  var sort = false.obs;



  var address = RxString();
  var name = RxString();
  var phone = RxString();
  var amount = RxDouble();
  var contractName = RxString();
  var contractDesc = RxString();
  var currExpenses=0.0.obs;


/* total contracts sum of a single project */
  var totalContractsAmounts=RxDouble();
  /*total wages sum of a single project */
 var totalWagesAmount=RxDouble();


  //to update the project at that id when  wage added

  @override
  void onInit() {
    allLabors.bindStream(Database().getAllLabors(
      selectProjectController.currentProject.value.id,
    ));
    allWagers.bindStream(Database().getAllWager(
      selectProjectController.currentProject.value.id,
    ));
    allContractors.bindStream(Database()
        .getAllContractLabors(selectProjectController.currentProject.value.id));

        
    totalContractsAmounts.bindStream(Database().getAllContractCost(selectProjectController
    .currentProject.value.id));
    totalWagesAmount.bindStream(Database().getAllWagesCost(selectProjectController
    .currentProject.value.id));
  }

/*when user add wage to labe that will be also added to the selected project */
  updateProjectTotalWage()  {
    FirebaseFirestore.instance
        .collection("Projects")
        .doc(selectProjectController.currentProject.value.id)
        .update({'totalWageAmount': this.totalWagesAmount.toString()}).then((value) => Fluttertoast
        .showToast(msg: "Request Submitted", backgroundColor:Colors.blue));
  }

   updateProjectTotalContractAmount() {
     FirebaseFirestore.instance
        .collection("Projects")
        .doc(selectProjectController.currentProject.value.id)
        .update({'totalContractAmount': this.totalContractsAmounts.toString()}).then((value) =>
         Fluttertoast.showToast(msg: 'Requested Submitted',backgroundColor: Colors.blue));
  }
  updateCurrExpense(){

    //update current total expenses inide of that project 
   FirebaseFirestore.instance.collection("Projects").doc(selectProjectController
    .currentProject.value.id).update({'currExpenses':(this.totalWagesAmount.value+this.totalContractsAmounts.value).toString()});


  }
 


 /* addLaborContract(DocumentReference reference) async {
    var contract = LaborContract(
        contractName: this.contractName.value,
        amount: this.amount.value,
        description: this.contractDesc.value);

    await reference.update({
      "contract": FieldValue.arrayUnion([contract.toMap()])
    });
  }*/

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        allLabors.sort((a, b) => a.name.compareTo(b.name));
      } else {
        allLabors.sort((a, b) => b.name.compareTo(a.name));
      }
    }
  }

  createPdf() async {

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
              pw.Header(child: pw.Row( 
              
                
                children:[ 
                  
                  
                  pw.Text('WAGERS REPORT'),
                  pw.Spacer(

                    
                  ),
                  pw.Column(
                    
                    children: [
                  
                    pw.Row(children: [
                        pw.Text('date created   '),
                
              
                 pw.Text(DateFormat.yMd().format(DateTime.now()))


                    ]),

                    pw.Row(children: [
                      pw.Text('project-ID   '),
                    pw.Text(this.selectProjectController.currentProject.value.id.substring(0,4)),


                    ]),
                    

                  ]),
                ] )
              
             ),
          
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  "Name",
                  "Phone",
                  "Address",
                  "Type",
                  "Amount",
                  "Days-Worked",
                  "Amount-Payable",
                  "Pay-Status"
                ],
                ...this.allWagers.map((labor) => [
                      labor.name,
                      labor.phone,
                      labor.address,
                      labor.laborType,
                      labor.amount.toString(),
                      labor.daysWorked.toString(),
                     (labor.daysWorked*labor.amount).toString(),
                      labor.paymentStatus == false ? "Not Paid" : "Payed"
                    ])
              ]),
              pw.Header(child: pw.Text('CONTRACT LABOR REPORT')),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  "Name",
                  "Phone",
                  "Address",
                  "Type",
                  "Contract",
                  "C-Amount",
                  "Pay-Status"
                
                ],
                ...this.allContractors.map((labor) => [
                      labor.name,
                      labor.phone,
                      labor.address,
                      labor.laborType,
                      labor.contract.contractName,
                      labor.amount.toString(),
                      labor.paymentStatus == false ? "Not Paid" : "Payed"

                    ]),
              ],
              
              
              ),
              pw.Divider(),
pw.Column(
   crossAxisAlignment:pw.CrossAxisAlignment.start,
  children: [
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,

      children: [
pw.Text('Customer:'),
  pw.Text(this.selectProjectController.currentProject.value.customer.name),



    ]),
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,

      children: [

        pw.Text('Phone'),
      

  pw.Text(this.selectProjectController.currentProject.value.customer.phone)
      ]

    ),
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,

      children: [

        pw.Text('Generated by:'),
      

  pw.Text(Get.find<UsrController>().currentUsr.value.name),
  
      ]

    ),
  
  

  

])
             /* pw.Table.fromTextArray(data: [

                [
                'Contract Description'

                ], ...this.allContractors.map((labor) => [

                  labor.contract.description
                ])
              ])*/
            






              
              // pw.Header(
              //     child: pw.Text(
              //         'ALL CONTRACTS OF PROJECT ${selectProjectController.currentProject.value.id.substring(0, 5)}')),
              // pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
              //   <String>[
              //     "Contract-Name",
              //     "Contract-Amount",
              //     "ProjectId",
              //   ],
              //   ...this
              //       .allContractors
              //       .map((contract) => contract.contract.map((e) {
              //             return [e.contractName, e.amount];
              //           }).toList()),
              // ])
            ]));

    //   final String dir = (await getApplicationDocumentsDirectory()).path;
    // var directory = await getApplicationDocumentsDirectory();

//package to access the download directory
    var downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;

    var path = downloadsDirectory.path;
    var fileName = DateTime.now().millisecondsSinceEpoch.toString();

    var file = File('$path/$fileName.pdf');
    //check current phone permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
  //  if (status.isGranted) {
      await file.writeAsBytes(this.pdf.save());
      Fluttertoast.showToast(msg: "Successfully Created & Downloaded");
      pdfViewrController.document.value =
          await PDFDocument.fromAsset(file.path); //read doc
      pdfViewrController.isLoading.value = false;
      pdfViewrController.appBarTitle.value = "Labor Report";
      Get.toNamed('pdfViewerUi');
    // } else {
    //   Fluttertoast.showToast(msg: "No Permisson");
    // }
  }
}
/*
  : this.currFilterOption.value == "Bank-Transfer"
            ? pdf.addPage(pw.MultiPage(
                pageFormat: PdfPageFormat.a4,
                build: (context) => [
                      pw.Table.fromTextArray(
                          context: context,
                          data: <List<String>>[
                            <String>[
                              "Bank",
                              "Account#"
                                  "Transaction-Type",
                              "Transaction-Mode",
                              "Payment-Type",
                              "Mode",
                              "Total-Amount",
                              "payment-Id",
                              "Added-by"
                            ],
                            ...this.allPaymentModeBank.map((val) => [
                                  val.bank.bankName,
                                  val.bank.accountNo,
                                  val.transactionType,
                                  val.transactionMode,
                                  val.paymentType,
                                  val.mode,
                                  val.totalAmount.toString(),
                                  val.paymentId.substring(1, 3),
                                  val.projectManager.name
                                ])
                          ])
                    ]))
            : this.currFilterOption.value == "Installment"
                ? pdf.addPage(pw.MultiPage(
                    pageFormat: PdfPageFormat.a4,
                    build: (context) => [
                          pw.Table.fromTextArray(
                              context: context,
                              data: <List<String>>[
                                <String>[
                                  "Transaction-Type",
                                  "Transaction-Mode",
                                  // "Payment-Type",
                                  // "Mode",
                                  // "Total-Amount",
                                  // "payment-Id",
                                  // "Added-by"
                                ],
                                ...this.allPaymentModeCash.map((val) =>
                                    [val.mode, val.totalAmount.toString()])
                              ])
                        ]))
                : this.currFilterOption.value == "Regular"
                    ? pdf.addPage(pw.MultiPage(
                        pageFormat: PdfPageFormat.a4,
                        build: (context) => [
                              pw.Table.fromTextArray(
                                  context: context,
                                  data: <List<String>>[
                                    <String>[
                                      "Transaction-Type",
                                      "Transaction-Mode",
                                      // "Payment-Type",
                                      // "Mode",
                                      // "Total-Amount",
                                      // "payment-Id",
                                      // "Added-by"
                                    ],
                                    ...this.allPaymentModeCash.map((val) =>
                                        [val.mode, val.totalAmount.toString()])
                                  ])
                            ]))
                    : pdf.addPage(pw.MultiPage(
                        pageFormat: PdfPageFormat.a4,
                        build: (context) => [
                              pw.Table.fromTextArray(
                                  context: context,
                                  data: <List<String>>[
                                    <String>[
                                      "Transaction-Type",
                                      "Transaction-Mode",
                                      // "Payment-Type",
                                      // "Mode",
                                      // "Total-Amount",
                                      // "payment-Id",
                                      // "Added-by"
                                    ],
                                    ...this.allPaymentModeCash.map((val) =>
                                        [val.mode, val.totalAmount.toString()])
                                  ])

*/
