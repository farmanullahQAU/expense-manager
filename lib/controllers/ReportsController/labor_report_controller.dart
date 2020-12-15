import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/errorHandler.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/ui/uploads_images/upload_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:expense_manager/models/labor_model.dart';
import 'package:expense_manager/controllers/ReportsController/pdf_viewer_controller.dart';

class LaborReportController extends GetxController {
  var selectProjectController = Get.find<SelectProjectController>();
  var pdfViewrController = Get.find<PdfViewrController>();

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

  /*add New labor contract */

  var contractDetailsTextController = TextEditingController().obs;
  var contractNameTextController = TextEditingController().obs;
  var selectedProjectController = Get.find<SelectProjectController>();

  TextEditingController amountTextEditingController = TextEditingController();
  final phoneNumberTextController = TextEditingController().obs;
  final nameTextController = TextEditingController().obs;
  final addressTextController = TextEditingController().obs;
  final laborTypeTextController = TextEditingController().obs;
  final contractDetailsFormKey = GlobalKey<FormState>().obs;

  /*add New labor contract */

  var address = RxString();
  var name = RxString();
  var phone = RxString();
  var amount = RxDouble();
  var contractName = RxString();
  var contractDesc = RxString();

  var contract = LaborContract().obs;

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
  }

  addLaborContract(DocumentReference reference) async {
    var contract = LaborContract(
        contractName: this.contractName.value,
        amount: this.amount.value,
        description: this.contractDesc.value);

    await reference.update({
      "contract": FieldValue.arrayUnion([contract.toMap()])
    });
  }

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
    //convert list of laborContract to ContractList

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
              pw.Header(child: pw.Text('WAGERS REPORT')),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  "Name",
                  "Phone",
                  "Address",
                  "Type",
                  "Amount",
                  "Days-Worked",
                  "Amount-Payable"
                ],
                ...this.allWagers.map((labor) => [
                      labor.name,
                      labor.phone,
                      labor.address,
                      labor.laborType,
                      labor.amount.toString(),
                      labor.daysWorked.toString(),
                      labor.totalWage
                    ])
              ]),
              pw.Header(child: pw.Text('CONTRACT LABOR REPORT')),
              pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
                <String>[
                  "Name",
                  "Phone",
                  "Address",
                  "Type",
                  "Amount",
                ],
                ...this.allContractors.map((labor) => [
                      labor.name,
                      labor.phone,
                      labor.address,
                      labor.laborType,
                      labor.amount.toString(),
                    ]),
              ]),
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
    if (status.isGranted) {
      await file.writeAsBytes(this.pdf.save());
      Fluttertoast.showToast(msg: "Successfully Created & Downloaded");
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
