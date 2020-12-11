import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:expense_manager/controllers/ReportsController/payment_report_controller.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PdfViewer extends GetWidget {
  var paymentReportController = Get.find<PaymentReportController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FlutterPluginPDFViewer'),
        ),
        body: Obx(() => paymentReportController.isLoading.value == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Colors.green,
                width: context.width * 0.9,
                child: PDFViewer(
                  document: Get.arguments,
                  zoomSteps: 1,

                  //   lazyLoad: false,
                  //  uncomment below line to scroll vertically
                  scrollDirection: Axis.vertical,

                  //uncomment below code to replace bottom navigation with your own
                  navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  },
                ),
              )));
  }
}
