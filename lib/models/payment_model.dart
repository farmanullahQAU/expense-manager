// enum tranType { onSpot, afterExpense, advance }
// enum tranInfo { regular, installment }

// class CustomerVendor<T> {
//   Vendor vendor;
//   Customer customer;
//   TransactionsType transaction;
//   T mode;
//   double totalAmount;
//   String description;

//   CustomerVendor(
//       {this.vendor,
//       this.customer,
//       this.transaction,
//       this.totalAmount,
//       this.description,
//       this.mode});

//   CustomerVendor.fromMap(Map<String, dynamic> map) {
//     this.transaction = map[TransactionsType.fromMap(map)];
//     this.customer = map[Customer.fromMap(map)];
//     this.vendor = map[Vendor.fromMap(map)];
//     this.totalAmount = map['totalAmount'];
//     this.description = map[' description'];
//     this.mode = map['mode'];
//   }
// }

// class PmVendor<T> {
//   double totalAmount;
//   String description;
//   Vendor vendor;
//   ProjectManager projectManager;
//   TransactionsType transaction;
//   T mode;

//   PmVendor(
//       {this.vendor,
//       this.projectManager,
//       this.transaction,
//       this.totalAmount,
//       this.description,
//       this.mode});

//   PmVendor.fromMap(Map<String, dynamic> map) {
//     this.vendor = map[Vendor.fromMap(map)];
//     this.transaction = map[TransactionsType.fromMap(map)];
//     this.projectManager = map[ProjectManager.fromMap(map)];
//     this.totalAmount = map['totalAmount'];
//     this.description = map[' description'];
//     this.mode = map['mode'];
//   }
// }

// class CustomerPM<T> {
//   Customer customer;
//   ProjectManager projectManager;
//   TransactionsType transaction;
//   double totalAmount;
//   String description;
//   T mode;

//   CustomerPM(
//       {this.customer,
//       this.projectManager,
//       this.transaction,
//       this.totalAmount,
//       this.description,
//       this.mode});
//   CustomerPM.fromMap(Map<String, dynamic> map) {
//     this.customer = map[Customer.fromMap(map)];
//     this.projectManager = map[ProjectManager.fromMap(map)];
//     this.transaction = map[TransactionsType.fromMap(map)];
//     this.totalAmount = map['totalAmount'];
//     this.description = map[' description'];
//     this.mode = map['mode'];
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsType {
  String transactionType;
  TransactionsType({this.transactionType});
  TransactionsType.fromMap(Map<String, dynamic> map) {
    this.transactionType = map['transactionType'];
  }
}

class TransactionMode {
  String transactionMode;
  TransactionMode({this.transactionMode});
  TransactionMode.fromMap(Map<String, dynamic> map)
      : this.transactionMode = map['transactionMode'];
}

enum logoUrls { regular, installment }

class Bank {
  String bankName;
  String accountNo;
  String logoUrl;
  //DocumentReference documentReference;

  Bank({
    this.bankName,
    this.accountNo,
    this.logoUrl,
  });

  Bank.fromMap(Map<String, dynamic> map) {
    this.bankName = map['bankName'];
    this.accountNo = map['accountNo'];
    this.logoUrl = map['logoUrl'];
    // this.documentReference = map['documentReference'];
  }

  Map<String, dynamic> toMap() => {
        'bankName': bankName,
        'accountNo': accountNo,
        'logoUrl': logoUrl,
      };
}

class PaymentMode {
  /* if Admin adds new mode or delte so we use new class*/
  String mode;
  PaymentMode({this.mode});

  PaymentMode.fromMap(Map<String, dynamic> map) {
    this.mode = map['mode'];
  }

  Map<String, dynamic> toMap() => {
        'mode': mode,
      };
}

class PaymentType {
  /* just for admin if he want to add new payment type*/
  String paymentType;
  PaymentType({this.paymentType});

  PaymentType.fromMap(Map<String, dynamic> map) {
    this.paymentType = map['paymentType'];
  }

  Map<String, dynamic> toMap() => {
        'paymentType': paymentType,
      };
}

class Payment<T> {
  String transactionType;
  Vendor vendor;
  String transactionMode;
  String paymentType;
  String mode;
  double totalAmount;
  String description;
  String projectId;
  Bank bank;
  String paymentId;

  Payment({
    this.transactionType,
    this.vendor,
    this.transactionMode,
    this.paymentType,
    this.mode,
    this.description,
    this.totalAmount,
    this.projectId,
    this.bank,
    this.paymentId,
  });

  Payment.fromMap(Map<String, dynamic> map) {
    this.vendor = map['vendor'] != null ? Vendor.fromMap(map['vendor']) : null;
    this.transactionMode = map['transactionMode'];
    this.paymentType = map[' paymentType'];
    // this.mode is Bank ? Bank.fromMap(map['mode']) : this.mode = map['mode'];
    /* https://stackoverflow.com/questions/55306746/how-to-use-generics-and-list-of-generics-with-json-serialization-in-dart */

    this.mode = map['mode']; // consider this
    this.description = map['description'];
    this.totalAmount = map['totalAmount'];
    this.transactionType = map['transactionType'];
    this.projectId = map['projectId'];
    this.bank = map['bank'] != null ? Bank.fromMap(map['bank']) : null;
    this.paymentId = map['paymentId'];
  }

  Map<String, dynamic> toMap() => {
        'transactionType': transactionType,
        'vendor': this.vendor == null ? null : vendor.toMap(),
        'transactionMode': transactionMode,
        'paymentType': paymentType,
        'mode': this.mode,
        'description': description,
        'totalAmount': totalAmount,
        'projectId': projectId,
        'bank': this.bank == null ? null : bank.toMap(),
        'paymentId': this.paymentId
      };
}

class Vendor {
  String name;
  String phoneNo;
  String address;
  Vendor({this.name, this.phoneNo, this.address});

  Vendor.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.phoneNo = map['phoneNo'];

    this.address = map['address'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phoneNo': phoneNo,
        'address': address,
      };
}
