import 'package:cloud_firestore/cloud_firestore.dart';

class LaborContract {
  String description;
  String contractName;
  double amount;
  /*one labor may work in different project with different contract so 
  we have used project id inside array of contract */
  String projectId;
  LaborContract({
    this.description,
    this.contractName,
    this.projectId,
    this.amount,
  });

  LaborContract.fromMap(Map<String, dynamic> map) {
    this.description = map['description'];
    this.contractName = map['contractName'];
    this.projectId = map['projectId'];
    this.amount = map['amount'];
  }
  Map<String, dynamic> toMap() => {
        'description': this.description,
        'contractName': this.contractName,
        'projectId': this.projectId,
        'amount': this.amount
      };
}

class Labor {
  DocumentReference reference;
  String name;
  String phone;
  String address;
  bool paymentStatus;
  String laborType;
  String paymentType;
  double amount;
  int daysWorked;
  String totalWage;
  List<LaborContract> contract;

  //To fetch all labor of a project we have used array of projectIds
  List<String> laborProjectIds;

  Labor(
      {this.name,
      this.paymentStatus,
      this.laborType,
      this.paymentType,
      this.amount,
      this.phone,
      this.address,
      this.contract,
      this.daysWorked,
      this.laborProjectIds,
      this.totalWage,
      this.reference});

  /* Labor.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.name = map['name'];
    this.phone = map[' phone'];
    this.address = map['address'];
    this.laborType = map['laborType'];
    this.paymentType = map['paymentType'];
    this.amount = map['amount'];
    this.contract =
        map['contract'] != null ? LaborContract.fromMap(map['contract']) : null;
    var projIds = map['laborProjectIds'];

    List<String> projIdsList = projIds.cast<String>();
    this.laborProjectIds = projIdsList;
  }
  */

  Labor.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.name = map['name'];
    this.phone = map['phone'];
    this.address = map['address'];
    this.laborType = map['laborType'];
    this.paymentType = map['paymentType'];
    this.amount = map['amount'];
    this.daysWorked = map['daysWorked'];
    this.totalWage = map['totalWage'];
    this.paymentStatus = map['paymentStatus'];

    if (map['contract'] != null) {
      var list = map['contract'] as List;
      var contractList = list.map((e) => LaborContract.fromMap(e)).toList();
      this.contract = contractList;
    } else
      this.contract = null;

    var projIds = map['laborProjectIds'];

    List<String> projIdsList = projIds.cast<String>();
    this.laborProjectIds = projIdsList;
  }

  Labor.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'address': address,
        'laborType': laborType,
        'paymentType': paymentType,
        'paymentStatus': paymentStatus == null ? false : true,
        'amount': amount,
        'totalWage': totalWage ?? "0.0",
        'daysWorked': this.daysWorked ?? 0,
        'contract': this.contract != null
            ? contract.map((labor) => labor.toMap()).toList()
            : null,
        'laborProjectIds': laborProjectIds
      };
}

class LaborTypes {
  String laborType;
  String typeId;
  LaborTypes({this.laborType, this.typeId});

  Map<String, dynamic> toMap() => {'laborType': laborType, 'typeId': typeId};
  LaborTypes.fromMap(Map<String, dynamic> map) {
    this.laborType = map['laborType'];
    this.typeId = map['typeId'];
  }
}
