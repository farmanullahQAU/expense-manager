/*class Usr {
  String name;
  String email;
  String id;
  String userType;
  String address;
  String phone;

  Usr(
      {this.name,
      this.id,
      this.email,
      this.userType,
      this.address,
      this.phone});

  Usr.fromMap(Map<String, dynamic> map) {
    this.email = map['email'];
    this.name = map[' name'];
    this.id = map['id'];
    this.userType = map['userType'];
    this.address = map['address'];
    this.phone = map['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'id': this.id,
        'email': this.email,
        'userType': this.userType,
        'address': this.address,
        'phone': this.phone
      };
}
*/
class Usr {
  String name;
  String email;
  String id;
  String userType;
  String address;
  String phone;

  Usr(
      {this.name,
      this.id,
      this.email,
      this.userType,
      this.address,
      this.phone});

  Usr.fromMap(Map<String, dynamic> map) {
    this.email = map['email'];
    this.name = map['name'];
    this.id = map['id'];
    this.userType = map['userType'];
    this.address = map['address'];
    this.phone = map['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'id': this.id,
        'email': this.email,
        'userType': this.userType,
        'address': this.address,
        'phone': this.phone
      };
}

// class Vendor {
//   String name;
//   String email;
//   String id;
//   String userType;
//   String address;
//   String phone;

//   Vendor(
//       {this.name,
//       this.id,
//       this.email,
//       this.userType,
//       this.address,
//       this.phone});

//   Vendor.fromMap(Map<String, dynamic> map) {
//     this.email = map['email'];
//     this.name = map[' name'];
//     this.id = map['id'];
//     this.userType = map['userType'];
//     this.address = map['address'];
//     this.phone = map['phone'];
//   }

//   Map<String, dynamic> toMap() => {
//         'name': this.name,
//         'id': this.id,
//         'email': this.email,
//         'userType': this.userType,
//         'address': this.address,
//         'phone': this.phone
//       };
// }

class ProjectManager {
  String name;
  String email;
  String id;
  String userType;
  String address;
  String phone;
  ProjectManager({name, id, email, userType, address, phone});

  ProjectManager.fromMap(Map<String, dynamic> map) {
    this.email = map['email'];
    this.name = map['name'];
    this.id = map['id'];
    this.userType = map['userType'];
    this.address = map['address'];
    this.phone = map['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'id': id,
        'email': email,
        'userType': userType,
        'address': address,
        'phone': phone
      };
}

class Customer {
  String name;
  String email;
  String id;
  String userType;
  String address;
  String phone;
  Customer({name, id, email, userType, address, phone});

  Customer.fromMap(Map<String, dynamic> map) {
    this.email = map['email'];
    this.name = map[' name'];
    this.id = map['id'];
    this.userType = map['userType'];
    this.address = map['address'];
    this.phone = map['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'id': id,
        'email': email,
        'userType': userType,
        'address': address,
        'phone': phone
      };
}

class Admin {
  String name;
  String email;
  String id;
  String userType;
  String address;
  String phone;
  Admin({name, id, email, userType, address, phone});

  Admin.fromMap(Map<String, dynamic> map) {
    this.email = map['email'];
    this.name = map[' name'];
    this.id = map['id'];
    this.userType = map['userType'];
    this.address = map['address'];
    this.phone = map['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'id': id,
        'email': email,
        'userType': userType,
        'address': address,
        'phone': phone
      };
}
