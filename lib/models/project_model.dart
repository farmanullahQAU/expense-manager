import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/models/project_contract_model.dart';
import 'package:expense_manager/models/user_model.dart';

class Project {
  Timestamp starDate;
  Timestamp endDate;
  String id;
  double estimatedCost;
  String customerRelation;
  String customerRemarks;
  Usr customer;
  ProjectContracts projectContract;
  Usr projectManager;

  Project(
      {this.starDate,
      this.endDate,
      this.customerRelation,
      this.customerRemarks,
      this.customer,
      this.id,
      this.estimatedCost,
      this.projectContract,
      this.projectManager});

  Project.fromMap(Map<String, dynamic> map) {
    this.starDate = map['starDate'];
    this.endDate = map[' endDate'];
    this.id = map['id'];
    this.estimatedCost = map['estimatedCost'];
    this.customerRelation = map['customerRelation'];
    this.customer = Usr.fromMap(map['customer']);
    //  this.projectContract = map[ProjectContracts.fromMap(map)];
    this.projectContract = ProjectContracts.fromMap(map['projectContract']);
    this.projectManager = Usr.fromMap(map['projectManager']);
  }

  Map<String, dynamic> toMap() => {
        'starDate': this.starDate,
        'endDate': this.endDate,
        'id': this.id,
        'estimatedCost': this.estimatedCost,
        'customerRelation': this.customerRelation,
        'customer': this.customer.toMap(),
        'projectContract': this.projectContract.topMap(),
        'projectManager': this.projectManager.toMap(),
      };
}
