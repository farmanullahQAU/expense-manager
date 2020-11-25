import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_contract_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/models/user_model.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference projec =
      FirebaseFirestore.instance.collection('projects');

  CollectionReference usrs = FirebaseFirestore.instance.collection("users");
  CollectionReference addPayment =
      FirebaseFirestore.instance.collection("payments");

  createNewUser(Usr usr) async {
// create user with custom user id
    await firestore
        .collection('users')
        .doc(usr.id)
        .set(usr.toMap())
        .catchError((error) {
      print('create New user error');
      print(error.toString());
      String errorMessage = handleError(error);
    });
  }
  // createNewUser(Usr usr) async {
  //   //create user without custom id
  //   await firestore.collection('users').add(usr.toMap()).catchError((error) {
  //     print('create New user error');
  //     print(error.toString());
  //     String errorMessage = handleError(error);
  //   });
  // }

  Future<Usr> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await firestore
        .collection("users")
        .doc(uid)
        .get()
        .catchError((error) {});
    return Usr.fromMap(documentSnapshot.data());
  }

/*
  Stream<List<Usr>> getAllUsers() {
    return firestore.collection('users').snapshots().map((snapshot) {
      List<Usr> stdList = List();
      snapshot.docs.forEach((element) {
        stdList.add(Usr.fromMap(element.data()));
      });
      return stdList;
    });
  }
  */

  //we wil use this if we don't need real time changes
  getAllProjects(String userId) {
    List<Project> projectList = List();
    try {
      firestore
          .collection('users')
          .doc(userId)
          .collection('pm_projects')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((queryDocumentSnapshot) {
          projectList.add(Project.fromMap(queryDocumentSnapshot.data()));
        });
        projectList.forEach((element) {
          print(element.estimatedCost.toString());
        });

        return projectList;
      });
    } on FirebaseException catch (err) {
      print('get project error');
      print(err.message);

      String errorMessage = handleError(err);
    }
  }

  getProjectContracts() {
    try {
      return firestore.collection('contracts').snapshots().map((querySnapshot) {
        List<ProjectContracts> contractList = List();

        querySnapshot.docs.forEach((queryDocumentSnapshot) {
          contractList
              .add(ProjectContracts.fromMap(queryDocumentSnapshot.data()));
        });
        return contractList;
      });
    } on FirebaseException catch (err) {
      handleError(err);
    }
  }

  getPaymentTransactionType() {
    try {
      return firestore
          .collection('transactionType')
          .snapshots()
          .map((querySnapshot) {
        List<TransactionsType> contractList = List();

        querySnapshot.docs.forEach((queryDocumentSnapshot) {
          contractList
              .add(TransactionsType.fromMap(queryDocumentSnapshot.data()));
        });
        return contractList;
      });
    } on FirebaseException catch (err) {
      handleError(err);
    }
  }

  getPaymentTypes() {
    try {
      return firestore
          .collection('paymentTypes')
          .snapshots()
          .map((querySnapshot) {
        List<PaymentType> paymentTypeList = List();

        querySnapshot.docs.forEach((queryDocumentSnapshot) {
          paymentTypeList
              .add(PaymentType.fromMap(queryDocumentSnapshot.data()));
        });
        return paymentTypeList;
      });
    } on FirebaseException catch (err) {
      handleError(err);
    }
  }

  getVendors() {
    try {
      return firestore.collection('vendors').snapshots().map((querySnapshot) {
        List<Vendor> paymentTypeList = List();

        querySnapshot.docs.forEach((queryDocumentSnapshot) {
          paymentTypeList.add(Vendor.fromMap(queryDocumentSnapshot.data()));
        });
        return paymentTypeList;
      });
    } on FirebaseException catch (err) {
      handleError(err);
    }
  }

  getTransactionMode() {
    try {
      return firestore
          .collection('TransactionMode')
          .snapshots()
          .map((querySnapshot) {
        List<TransactionMode> transactionList = List();

        querySnapshot.docs.forEach((queryDocumentSnapshot) {
          transactionList
              .add(TransactionMode.fromMap(queryDocumentSnapshot.data()));
        });
        return transactionList;
      });
    } on FirebaseException catch (err) {
      handleError(err);
    }
  }

  getPaymentModes() {
    try {
      return firestore.collection("paymentModes").snapshots().map((event) {
        List<PaymentMode> contractList = List();

        event.docs.forEach((element) {
          contractList.add(PaymentMode.fromMap(element.data()));
        });
        return contractList;
      });
    } catch (error) {
      handleError(error);
    }
  }

  getBankAccounts(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('bank_accounts')
        .snapshots()
        .map((querySnapshot) {
      List<Bank> projects = List();
      querySnapshot.docs.forEach((queryDocumentSnapshot) {
        projects.add(Bank.fromMap(queryDocumentSnapshot.data()));
      });
      return projects;
    });
  }

  Future<bool> isAccountExist(String uId, String bankName) async {
    final QuerySnapshot result = await firestore
        .collection('users')
        .doc(uId)
        .collection('bank_accounts')
        .where('bankName', isEqualTo: bankName)
        .limit(1)
        .get();
    final List<QueryDocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

  Stream<List<Usr>> getCutomers() {
    return firestore
        .collection('users')
        .where('userType', isEqualTo: 'Customer')
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        print('no customer exists');
      }

      List<Usr> customerList = List();
      querySnapshot.docs.forEach((queryDocumentSnapshot) {
        print(queryDocumentSnapshot.id);
        if (queryDocumentSnapshot.exists) {
          print('we found ');
        }
        customerList.add(Usr.fromMap(queryDocumentSnapshot.data()));
      });
      return customerList;
    });
  }

  Stream<List<dynamic>> getPayments(String projId) {
    return firestore
        .collection('payments')
        .where('projectId', isEqualTo: projId)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        print('no Payments exists');
      }

      List<Payment> paymentList = List();
      querySnapshot.docs.forEach((queryDocumentSnapshot) {
        print(queryDocumentSnapshot.id);
        if (queryDocumentSnapshot.exists) {
          print('we found ');
        }
        paymentList.add(Payment.fromMap(queryDocumentSnapshot.data()));
      });
      return paymentList;
    });
  }

  getOnPmAllProjects(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('pm_projects')
        .snapshots()
        .map((querySnapshot) {
      List<Project> projects = List();
      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
        print('current pm all projects id');
        projects.add(Project.fromMap(queryDocumentSnapshot.data()));
      });
      return projects;
    });
  }

  //this function adds project inside the user collection with differnt id of project document id
/*
  addProjectToDb2(Project project) async {
    var documentReference = await projec.add(project.toMap());
    var dos = await documentReference
        .collection('proj_pm')
        .add(project.projectManager.toMap());
    var pmProjDoc = usrs
        .doc(project.projectManager.id)
        .collection('pm_projects')
        .add(project.toMap());
  }
  */

  // addProjectToDb3(Project project) async {
  //   var documentReference = await projec.add(project.toMap());
  //   var dos = await documentReference
  //       .collection('proj_pm')
  //       .add(project.projectManager.toMap());
  //   var pmProjDoc = usrs
  //       .doc(project.projectManager.id)
  //       .collection('pm_projects')
  //       .doc(documentReference.id)
  //       .set(project.toMap());
  // }

  addProjectToDb3(Project project) async {
    var documentReferenceId =
        FirebaseFirestore.instance.collection('Projects').doc().id;
    project.id = documentReferenceId;
    await projec.doc(documentReferenceId).set(project.toMap());
    FirebaseFirestore.instance
        .collection("projects")
        .doc(documentReferenceId)
        .collection('proj_pm')
        .add(project.projectManager.toMap());

    await usrs
        .doc(project.projectManager.id)
        .collection('pm_projects')
        .add(project.toMap());
  }

  addPaymentToDB(Payment payment) async {
    var documentReference = addPayment.doc();
    payment.paymentId = documentReference.id;
    await addPayment.doc(documentReference.id).set(payment.toMap());
  }

  addBankAccountToDB(Bank bank, String uid) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('bank_accounts')
        .add(bank.toMap());
  }
}
