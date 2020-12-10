import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/ReportsController/project_report_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectReprot extends GetWidget<ProjectReportController> {
  var selectedProj = Get.find<SelectProjectController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projec Report'),
      ),
      body: Container(
        width: context.width,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Projects')
                .where("id", isEqualTo: selectedProj.currentProject.value.id)
                .limit(1)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((e) {
                    var project = Project.fromMap(e.data());

                    print('project Id');
                    print(project.id);

                    return Column(
                      crossAxisAlignment: context.isLandscape
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        DataTable(
                          headingRowHeight: 56.0,
                          columns: [
                            DataColumn(label: Text('Date_start')),
                            DataColumn(label: Text('customer')),
                            DataColumn(label: Text('Est_cost')),
                            DataColumn(label: Text('contract')),
                            DataColumn(label: Text('customer_ph')),
                            DataColumn(label: Text('Date_end')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(project.starDate)),
                              DataCell(Text(project.customer.name)),
                              DataCell(Text(project.estimatedCost.toString())),
                              DataCell(
                                  Text(project.projectContract.contractName)),
                              DataCell(Text(project.customer.phone)),
                              DataCell(Text(project.endDate)),
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
                child: Text('no record found'),
              ));
            }),
      ),
    );
  }
}
