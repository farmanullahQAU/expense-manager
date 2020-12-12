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

import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/ui/uploads_images/upload_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class PaymentReportController extends GetxController {
  var isLoading = true.obs;
  var document = PDFDocument(); //to view pdf
  var pdf = pw.Document(); //create pdf
  var savedLoc = RxString();
  var currProject = Project().obs;

  var projectList = List<Project>().obs;
  var paymentTypeList = List<PaymentType>().obs;
  var currPaymentType = PaymentType().obs;
  var paymentReportFormKey = GlobalKey<FormState>().obs;
  final roundLoadingPaymentReportContr =
      new RoundedLoadingButtonController().obs;

  var allPayments = List<Payment>().obs;
  var allPaymentModeCash = List<Payment>().obs;
  var allPaymentModeBank = List<Payment>().obs;

  var filterOption = ["Cash", "Bank-Transfer", "Installment", "Regular"].obs;
  var currFilterOption = RxString();
  var sort = false.obs;

  @override
  void onInit() async {
    projectList.bindStream(
        Database().getOnPmAllProjects(FirebaseAuth.instance.currentUser.uid));
    paymentTypeList.bindStream(Database().getPaymentTypes());
    allPayments.bindStream(Database().getppppp());
    allPaymentModeCash.bindStream(Database().getAllCashPayments());
    allPaymentModeBank.bindStream(Database().getAllBankPayments());
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
              pw.Header(child: pw.Text('Payment Report')),
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
                    ]),
              ]),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
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

      document = await PDFDocument.fromAsset(file.path); //read doc
      this.isLoading.value = false;

      Get.toNamed('pdfViewerUi', arguments: this.document);
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
