import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:expense_manager/controllers/ReportsController/payment_report_controller.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';

class PdfViewrController extends GetxController {
  var documentt = PDFDocument();
  var pdf = pw.Document();

  var dir = RxString();

  var path = RxString();
  var file = Rx<File>();

  @override
  void onInit() {
    this.allPaymentModeCash = reportController.allPaymentModeCash;
    // allPayments.bindStream(Database().getppppp());
    // allPaymentModeCash.bindStream(Database().getAllCashPayments());
    // allPaymentModeBank.bindStream(Database().getAllBankPayments());
  }

  var allPayments = List<Payment>().obs;
  var allPaymentModeCash = List<Payment>().obs;
  var allPaymentModeBank = List<Payment>().obs;
  var reportController = Get.find<PaymentReportController>();
  var isLoading = true.obs;
  var document = PDFDocument().obs; //to view pdf

  addDocs() async {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  "Transaction-Type",
                  "Transaction-Mode",
                  // "Payment-Type",
                  // "Mode",
                  // "Total-Amount",
                  // "payment-Id",
                  // "Added-by"
                ],
                ...this
                    .allPayments
                    .map((val) => [val.mode, val.totalAmount.toString()])
              ])
            ]));
    this.dir.value = (await getApplicationDocumentsDirectory()).path;
    this.path.value = '$dir/report.pdf';
    this.file.value = File(this.path.value);
    await file.value.writeAsBytes(pdf.save());
    documentt = await PDFDocument.fromAsset(file.value.path);
    this.isLoading.value = false;

    // 5s over, navigate to a new page
  }

  navigate() {
    Get.toNamed('pdfViewerUi', arguments: documentt);
  }
}
