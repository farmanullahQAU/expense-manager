import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/ReportsController/payment_report_controller.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentReport extends GetWidget<PaymentReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Report'),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataTable(
                dataRowHeight: 0,
                rows: [
                  DataRow(cells: [
                    DataCell(
                      Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                    DataCell(Container(
                      width: 0.0,
                      height: 0.0,
                    )),
                    DataCell(Container(
                      width: 0.0,
                      height: 0.0,
                    )),
                  ])
                ],
                columns: [
                  DataColumn(label: Text('Mode')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('project Id')),
                  DataColumn(label: Text('Mode')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('project Id')),
                ],
              ),
              Container(
                width: context.width,
                child: StreamBuilder<QuerySnapshot>(
                    // stream: Database().getPayments(controller.currProject.value.id),
                    stream: FirebaseFirestore.instance
                        .collection('payments')
                        .where("projectId",
                            isEqualTo: controller.currProject.value.id)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          !snapshot.hasData) {
                        /* if snapshot is not null yet beacuse the network is in waitng state*/
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            )
                          ],
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done &&
                          !snapshot.hasData) {
                        return Center(
                          child: Text('no record found'),
                        );
                      }

                      if (snapshot.hasData) {
                        return ListView(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // padding: const EdgeInsets.only(top: 20.0),
                          children: snapshot.data.docs.map((e) {
                            var record = Payment.fromMap(e.data());

                            print('project Id');
                            print(record.projectId);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DataTable(
                                  headingRowHeight: 0,
                                  columns: [
                                    DataColumn(label: Text('Amount')),
                                    DataColumn(label: Text('project Id')),
                                    DataColumn(label: Text('Transaction Date')),
                                    DataColumn(label: Text('Mode')),
                                    DataColumn(label: Text('Transaction Date')),
                                    DataColumn(label: Text('Mode')),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text(record.mode)),
                                      DataCell(
                                          Text(record.totalAmount.toString())),
                                      DataCell(Text(record.transactionMode)),
                                      DataCell(Text(record.mode)),
                                      DataCell(
                                          Text(record.totalAmount.toString())),
                                      DataCell(Text(record.mode)),
                                    ])
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return Center(
                          child: Container(
                        child: Text('no Payment added to this project'),
                      ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
