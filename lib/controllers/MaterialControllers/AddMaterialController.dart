
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/models/material_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/db_services/database.dart';
class AddMaterialController extends GetxController{


  final auth = FirebaseAuth.instance.currentUser;
  TextEditingController materialNameTextEditCont = TextEditingController();
  TextEditingController materialUnitPriceTextEditCont = TextEditingController();
  TextEditingController materialTotalCostTextEditCont = TextEditingController();

  TextEditingController materialQtyTextEditCont = TextEditingController();
  var allVendors=List<Vendor>().obs;
  
  var materialNameString = RxString();
  var materialUnitPriceString = RxString();
  var materialQtyString = RxString();
  var materialDatePurchStrig=RxString();
  var totalCostStrig=RxString();
  var currentVendor=Rx<Vendor>();
  var currUnit=RxString();
  var unitList=List<String>().obs;
  var addMaterialRountButton=RoundedLoadingButtonController().obs;
  var usrController=Get.find<UsrController>();





  


  final addMaterialFormKey = GlobalKey<FormState>().obs;
   @override
  void onInit()async
  {
     allVendors.bindStream(Database().getVendors());
    unitList.value=await Database().getMaterialUnits();
    // transactionTypeList.bindStream(Database().getPaymentTransactionType());
    // transactionModeList.bindStream(Database().getTransactionMode());
    // paymentTypeList.bindStream(Database().getPaymentTypes());
    // vendorList.bindStream(Database().getVendors());
  }

  addMaterial(BuildContext context)async {
    print(this.totalCostStrig.value);

    final material=new Materials(

      materialName: this.materialNameString.value, quantity: this.materialQtyString.value,
       unit: this.currUnit.value,
      unitPrice: this.materialUnitPriceString.value,vendor:this.currentVendor.value,
      buyour: this.usrController.currentUsr.value, 
      total: this.totalCostStrig.value

    );


   await Database().addBuyMaterialToDb( material);
      this.addMaterialRountButton.value.success();

   Get.defaultDialog(
     title: 'Add Another', middleText: 'do you want to add another ?',
     confirmTextColor: Get.isDarkMode?Theme.of(context).primaryColor:Colors.white,
     onConfirm: (){
      
      this.clear();
      this.addMaterialRountButton.value.stop();
      Get.back();

       
     },
     onCancel: (){
      Get.back();

     },
    textConfirm: 'Yes',
   );






  }
  clear(){
this.addMaterialRountButton.value.stop();
      this.materialNameTextEditCont.clear();
      this.materialQtyTextEditCont.clear();
      this.materialUnitPriceTextEditCont.clear();
      this.materialTotalCostTextEditCont.clear();
     

  }

}