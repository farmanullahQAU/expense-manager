import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/labor_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddLaborCategoryController extends GetxController{


  var categoryTextCotroller=TextEditingController().obs;
  var addCategoryFormKey=GlobalKey<FormState>().obs;
  var categoryString=RxString();
  var category=LaborTypes();


  void addLaborCategoryToDb(){
    var type=LaborTypes(laborType:categoryString.value);

FirebaseFirestore.instance.collection("LaborTypes").add(type.toMap()).then((value) => Fluttertoast.showToast(msg: 'Category Addedd')).catchError((err)=>Fluttertoast.showToast(backgroundColor: Colors.red,msg: 'Something went wrong'));
  }
}