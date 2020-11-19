class ProjectContracts {
  String contractName;
  String contractDes;
  ProjectContracts({this.contractName, this.contractDes});
  ProjectContracts.fromMap(Map<String, dynamic> map) {
    this.contractName = map['contractName'];
    this.contractDes = map['contractDes'];
  }

  Map<String, dynamic> topMap() => {
        'contractName': this.contractName,
        'contractDes': this.contractDes,
      };
}
