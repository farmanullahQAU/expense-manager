import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editable/editable.dart';
import 'package:expense_manager/controllers/ReportsController/payment_report_controller.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/db_services/database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentReport extends GetWidget<PaymentReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
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
        title: Text('Payment Report'),
      ),
      body: controller.allPayments == null
          ? CircularProgressIndicator()
          :
          // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
          Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Text("Report"),
                    controller.currFilterOption.value == "Cash"
                        ? paymentCash()
                        : controller.currFilterOption.value == "Bank-Transfer"
                            ? paymentBankTransfered()
                            : addTable1(),
                  ],
                )),
              ),
            ),
    );
  }

  DataTable addTable1() {
    return DataTable(
      columns: [
        DataColumn(
            label: Text('Transaction-Type'),
            tooltip: 'Transaction type of the payment.'),
        DataColumn(
            label: Text('Transaction-Mode'), tooltip: 'Transaction Mode'),
        DataColumn(label: Text('Payment-Type'), tooltip: 'Payment Type'),
        DataColumn(label: Text('Mode'), tooltip: 'Payment Mode'),
        DataColumn(label: Text('Total-Amount'), tooltip: 'Total Amount'),
        DataColumn(label: Text('payment-Id'), tooltip: 'Payment Id'),
        DataColumn(label: Text('Added-by'), tooltip: 'Added by '),
      ],
      rows: controller.allPayments
          .map((data) =>
              // we return a DataRow every time

              DataRow(
                  // List<DataCell> cells is required in every row
                  cells: [
                    // DataCell((data.verified)
                    //     ? Icon(
                    //         Icons.verified_user,
                    //         color: Colors.green,
                    //       )
                    //     : Icon(Icons.cancel, color: Colors.red)),
                    // I want to display a green color icon when user is verified and red when unverified
                    DataCell(Text(data.transactionType)),
                    DataCell(Text(data.transactionMode)),
                    DataCell(Text(data.paymentType)),

                    DataCell(Text(data.mode)),
                    DataCell(Text(data.totalAmount.toString())),
                    DataCell(Text(data.paymentId.substring(0, 3))),
                    DataCell(Text(data.projectManager.name)),
                  ]))
          .toList(),
    );
  }

  DataTable paymentCash() {
    return DataTable(
      columns: [
        DataColumn(
            label: Text('Transaction-Type'),
            tooltip: 'Transaction type of the payment.'),
        DataColumn(
            label: Text('Transaction-Mode'), tooltip: 'Transaction Mode'),
        DataColumn(label: Text('Payment-Type'), tooltip: 'Payment Type'),
        DataColumn(label: Text('Mode'), tooltip: 'Payment Mode'),
        DataColumn(label: Text('Total-Amount'), tooltip: 'Total Amount'),
        DataColumn(label: Text('payment-Id'), tooltip: 'Payment Id'),
        DataColumn(label: Text('Added-by'), tooltip: 'Added by '),
        DataColumn(label: Text('PM-Phone'), tooltip: 'Project manager Phone'),
      ],
      rows: controller.allPaymentModeCash
          .map((data) =>
              // we return a DataRow every time

              DataRow(
                  // List<DataCell> cells is required in every row
                  cells: [
                    // DataCell((data.verified)
                    //     ? Icon(
                    //         Icons.verified_user,
                    //         color: Colors.green,
                    //       )
                    //     : Icon(Icons.cancel, color: Colors.red)),
                    // I want to display a green color icon when user is verified and red when unverified

                    DataCell(Text(data.transactionType)),
                    DataCell(Text(data.transactionMode)),
                    DataCell(Text(data.paymentType)),

                    DataCell(Text(data.mode)),
                    DataCell(Text(data.totalAmount.toString())),
                    DataCell(Text(data.paymentId.substring(0, 3))),
                    DataCell(Text(data.projectManager.name)),
                    DataCell(Text(data.projectManager.phone)),
                  ]))
          .toList(),
    );
  }

  DataTable paymentBankTransfered() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Bank'), tooltip: 'Bank Name'),
        DataColumn(label: Text('Account#'), tooltip: 'Account Number'),
        DataColumn(
            label: Text('Transaction-Type'),
            tooltip: 'Transaction type of the payment.'),
        DataColumn(
            label: Text('Transaction-Mode'), tooltip: 'Transaction Mode'),
        DataColumn(label: Text('Payment-Type'), tooltip: 'Payment Type'),
        DataColumn(label: Text('Mode'), tooltip: 'Payment Mode'),
        DataColumn(label: Text('Total-Amount'), tooltip: 'Total Amount'),
        DataColumn(label: Text('payment-Id'), tooltip: 'Payment Id'),
        DataColumn(label: Text('Added-by'), tooltip: 'Added by '),
        DataColumn(label: Text('PM-Phone'), tooltip: 'Project manager Phone'),
      ],
      rows: controller.allPaymentModeBank
          .map((data) => DataRow(cells: [
                DataCell(Text(data.bank.bankName)),
                DataCell(Text(data.bank.accountNo)),
                DataCell(Text(data.transactionType)),
                DataCell(Text(data.transactionMode)),
                DataCell(Text(data.paymentType)),
                DataCell(Text(data.mode)),
                DataCell(Text(data.totalAmount.toString())),
                DataCell(Text(data.paymentId.substring(0, 3))),
                DataCell(Text(data.projectManager.name)),
                DataCell(Text(data.projectManager.phone)),
              ]))
          .toList(),
    );
  }
}
