import 'package:cloud_firestore/cloud_firestore.dart';

class LaborContract {
  String description;
  String contractName;
  LaborContract({this.description, this.contractName});

  LaborContract.fromMap(Map<String, dynamic> map) {
    this.description = map['description'];
    this.contractName = map['contractName'];
  }
  Map<String, dynamic> toMap() => {
        'description': this.description,
        'contractName': this.contractName,
      };
}

class Labor {
  DocumentReference reference;
  String name;
  String phone;
  String address;
  String laborType;
  String paymentType;
  double amount;
  LaborContract contract;
  List<String> laborProjectIds;

  Labor(
      {this.name,
      this.laborType,
      this.paymentType,
      this.amount,
      this.phone,
      this.address,
      this.contract,
      this.laborProjectIds});

  Labor.fromMap(Map<String, dynamic> map, {this.reference}) {
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

  Labor.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'address': address,
        'laborType': laborType,
        'paymentType': paymentType,
        'amount': amount,
        'contract': this.contract == null ? null : contract.toMap(),
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
    this.typeId = map[' typeId'];
  }
}
