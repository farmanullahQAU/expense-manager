import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectContracts {
  String contractName;
  String contractDesc;
  DocumentReference reference;
  ProjectContracts({this.contractName, this.contractDesc});
  ProjectContracts.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.contractName = map['contractName'];
    this.contractDesc = map['contractDesc'];
  }

  Map<String, dynamic> topMap() => {
        'contractName': this.contractName,
        'contractDesc': this.contractDesc,
      };

  ProjectContracts.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data(),
            reference: documentSnapshot.reference);
}
