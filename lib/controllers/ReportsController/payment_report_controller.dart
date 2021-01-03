import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:expense_manager/db_services/database.dart';
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
import 'package:expense_manager/controllers/ReportsController/pdf_viewer_controller.dart';

import 'package:expense_manager/db_services/database.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class PaymentReportController extends GetxController {
  var selectProjectController = Get.find<SelectProjectController>();
  var pdfViewrController = Get.find<PdfViewrController>();

  var pdf = pw.Document(); //create pdf
  var savedLoc = RxString();

  var allPayments = List<Payment>().obs;
  var allPaymentModeCash = List<Payment>().obs;
  var allPaymentModeBank = List<Payment>().obs;

  var filterOption = ["Cash", "Bank-Transfer", "Installment", "Regular"].obs;
  var currFilterOption = RxString();
  var sort = false.obs;

  @override
  void onInit() async {
    allPayments.bindStream(
        Database().getppppp(selectProjectController.currentProject.value.id));
    allPaymentModeCash.bindStream(Database()
        .getAllCashPayments(selectProjectController.currentProject.value.id));
    allPaymentModeBank.bindStream(Database()
        .getAllBankPayments(selectProjectController.currentProject.value.id));
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        allPaymentModeCash
            .sort((a, b) => a.transactionType.compareTo(b.transactionType));
      } else {
        allPaymentModeCash
            .sort((a, b) => b.transactionType.compareTo(a.transactionType));
      }
    }
  }

  createPdf() async {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
              pw.Header(child: pw.Text('CASH PAYMENT REPORT')),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  "Transaction-Type",
                  "Transaction-Mode",
                  "Payment-Type",
                  "Mode",
                  "Total-Amount",
                  "payment-Id",
                  "Added-by"
                ],
                ...this.allPaymentModeCash.map((val) => [
                      val.transactionType,
                      val.transactionMode,
                      val.paymentType,
                      val.mode,
                      val.totalAmount.toString(),
                      val.paymentId.substring(1, 3),
                      val.projectManager.name
                    ])
              ]),
              pw.Header(child: pw.Text('BANK TRANSFERED PAYMENT REPORT')),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  "Bank",
                  "Account#",
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
              ]),
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
  
      await file.writeAsBytes(this.pdf.save());
      Fluttertoast.showToast(msg: "Successfully Created & Downloaded");
      //set variable document of pdfViewrController
      pdfViewrController.document.value =
          await PDFDocument.fromAsset(file.path); //read doc
      pdfViewrController.isLoading.value = false;

      //set appBar title
      pdfViewrController.appBarTitle.value = "Payment Report";
      Get.toNamed('pdfViewerUi');
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
