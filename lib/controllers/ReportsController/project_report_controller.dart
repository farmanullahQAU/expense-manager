import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';


import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:expense_manager/controllers/ReportsController/pdf_viewer_controller.dart';

class ProjectReportController extends GetxController {


  var pdfViewrController = Get.find<PdfViewrController>();

  var isLoading = true.obs;
  var document = PDFDocument(); //to view pdf
  var pdf = pw.Document(); //create pdf
  var savedLoc = RxString();

  

  

  var address = RxString();
  var name = RxString();
  var phone = RxString();
  var amount = RxDouble();
  var contractName = RxString();
  var contractDesc = RxString();
  var totalWageAmount = 0.0.obs;
  var totalContractsAmounts = 0.0.obs;


  // @override
  // void onInit() {
  //   // pmAllProjects.bindStream(Database().getOnPmAllProjects(
  //   //   usrController.currentUsr.value.id
  //   // ));
  //   // customerAllProjects.bindStream(Database().getAllWager(
  //   //  usrController.currentUsr.value.id
  //   // ));
  //   // adminAllProjects.bindStream(Database()
  //   //     .getAllContractLabors
  //   //     (
  //   //     usrController.currentUsr.value.id));
  // }

/*when user add wage to labe that will be also added to the selected project */
  // updateProjectTotalWage() {
  //   FirebaseFirestore.instance
  //       .collection("Projects")
  //       .doc(currProject.value.id)
  //       .update({'totalWageAmount': this.totalWageAmount.toString()});
  // }

  //  updateProjectTotalContractAmount() {
  //   FirebaseFirestore.instance
  //       .collection("Projects")
  //       .doc(currProject.value.id)
  //       .update({'totalContractAmount': this.totalContractsAmounts.toString()});
  // }


 /* addLaborContract(DocumentReference reference) async {
    var contract = LaborContract(
        contractName: this.contractName.value,
        amount: this.amount.value,
        description: this.contractDesc.value);

    await reference.update({
      "contract": FieldValue.arrayUnion([contract.toMap()])
    });
  }*/

 

  createPdf(Project currProject) async {
   print('this proj..........................');
                  print(currProject.id);

    //convert list of laborContract to ContractList

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
              pw.Header(child: pw.Row( 
              
                
                children:[ 
                  
                  
                  pw.Text('Project Report'),
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
                    pw.Text(currProject.id.substring(0,4)),


                    ]),
                    

                  ]),
                ] )
              
             ),
           

           
          
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  "Id",
                  "Start",
                  "Est-Cost",
                  "Contract",
                  "Customer",
                  "Phone",
                  "Email",
                  "End"
                ],
                [
                  currProject.id.substring(0,4),
                  currProject.starDate,
                  currProject.starDate,
                  currProject.estimatedCost,
                  currProject.projectContract.contractName,
                  currProject.customer.phone,
                  currProject.customer.email,
                  currProject.endDate,


                      
                    ]
              ]),
            /*  pw.Header(child: pw.Text('CONTRACT LABOR REPORT')),
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
              */
             /* pw.Table.fromTextArray(data: [

                [
                'Contract Description'

                ], ...this.allContractors.map((labor) => [

                  labor.contract.description
                ])
              ])*/
            






              
              // pw.Header(
              //     child: pw.Text(
              //         'ALL CONTRACTS OF PROJECT ${currProject.value.id.substring(0, 5)}')),
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
   // var fileName = DateTime.now().millisecondsSinceEpoch.toString();

    //var file = File('$path/$fileName.pdf');
    var file = File('$path/projectReport.pdf');

    //check current phone permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      await file.writeAsBytes(this.pdf.save());
      
      Fluttertoast.showToast(msg: "Downloaded ");
      pdfViewrController.document.value =
          await PDFDocument.fromAsset(file.path); //read doc
      pdfViewrController.isLoading.value = false;
      pdfViewrController.appBarTitle.value = "Labor Report";
      Get.toNamed('pdfViewerUi');
    } else {
      Fluttertoast.showToast(msg: "No Permisson");
    }
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
