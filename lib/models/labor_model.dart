import 'package:cloud_firestore/cloud_firestore.dart';

class LaborContract {
  String description;
  String contractName;
  
  String projectId;
  LaborContract({
    this.description,
    this.contractName,
    this.projectId,
  });

  LaborContract.fromMap(Map<String, dynamic> map) {
    this.description = map['description'];
    this.contractName = map['contractName'];
    this.projectId = map['projectId'];
  }
  Map<String, dynamic> toMap() => {
        'description': this.description,
        'contractName': this.contractName,
        'projectId': this.projectId,
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
  LaborContract contract;

  //To fetch all labor of a project we have used array of projectIds
 // List<String> laborProjectIds;
 String laborProjectIds;

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
    this.paymentStatus = map['paymentStatus'];

    // if (map['contract'] != null) {
    //   var list = map['contract'] as List;
    //   var contractList = list.map((e) => LaborContract.fromMap(e)).toList();
    //   this.contract = contractList;
    // } else
    //   this.contract = null;
      this.contract=  map['contract'] != null ? LaborContract.fromMap(map['contract']) : null;


  this.laborProjectIds = map['laborProjectIds'];

    // List<String> projIdsList = projIds.cast<String>();
    // this.laborProjectIds = projIdsList;
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
        'daysWorked': this.daysWorked ?? 0,
      /*  'contract': this.contract != null
            ? contract.map((labor) => labor.toMap()).toList()
            : null,*/

          'contract':contract==null?null:this.contract.toMap(),
        'laborProjectIds': laborProjectIds
      };
}

class LaborTypes {
  String laborType;
  LaborTypes({this.laborType});

  Map<String, dynamic> toMap() => {'laborType': laborType};
  LaborTypes.fromMap(Map<String, dynamic> map) {
    this.laborType = map['laborType'];
  }
}
