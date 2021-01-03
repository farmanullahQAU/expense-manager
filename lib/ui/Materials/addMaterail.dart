import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_manager/controllers/paymentController/add_paymentController.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:expense_manager/controllers/MaterialControllers/AddMaterialController.dart';

import 'package:flutter/cupertino.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddMaterial extends GetWidget<AddMaterialController> {
  List<Usr> customers = new List();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              })
        ],
        //  backgroundColor: Colors.teal,
        title: Text('Add Material'),
      ),
      body: Container(
        
        child: Form(
          key: controller.addMaterialFormKey.value,
          child: addForm(context),
        ),
        margin: EdgeInsets.all(20),
      ),
    )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget addForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text('Buy Material'),
          ),
          addFirstRow(context),
          addSecondRow(context),
          addThirddRow(context),
         addFourthColumn(context),
        ],
      ),
    );
  }

  Widget addFirstRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        // //  width: isLandscap(context) ? 10 : 5,
        // ),

        Flexible(
          child: Obx(() {
            if (controller.allVendors != null)
              return DropdownButtonFormField(
                
                  validator: (val) =>
                      val == null ? "Plz select vendor" : null,

                  // isDense: true,

                  decoration: InputDecoration(
                    /* enabledBorder: InputBorder.none that will remove the border and also the upper left 
                and right cut corner  */
                    contentPadding: EdgeInsets.only(left: 8),
                    /* 
                
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                */
                    filled: true,
                  ),
                  hint: Text('Select Vendor'),
                  items: controller.allVendors.map((vendor) {
                    return DropdownMenuItem<Vendor>(
                        value: vendor,
                        child: Column(
                          children: [Text(vendor.name)],
                        ));
                  }).toList(),
                  onChanged: (Vendor vendor) {
                 controller.currentVendor.value=vendor;
                  });
            return Text('loading...');
          }),
        ),
      ],
    );
  }

  Widget addSecondRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          // //  width: isLandscap(context) ? 10 : 5,
          // ),

          Flexible(
            child: TextFormField(
              controller: controller.materialNameTextEditCont,
              validator: (val) =>
                  val.isEmpty ? "Plz enter material name" : null,
              onSaved: (val) => controller.materialNameString.value =val,
              maxLength: 9,
              // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              // keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  filled: true,
                  // prefixIcon: Icon(
                  //   Icons.sho,
                  // ),
                  labelText: 'Material name'),
            ),
          ),
          SizedBox(
            width: context.isLandscape ? 10 : 5,
          ),
           Flexible(
            child: TextFormField(
              onChanged: (qtyVal){
controller.materialTotalCostTextEditCont.text=(double.parse(controller.materialUnitPriceTextEditCont.text)*double.parse(qtyVal)).toString();



              },
              controller: controller.materialQtyTextEditCont,
              
              validator: (val) =>
                  val.isEmpty ? "Plz enter material quantity" : null,
              onSaved: (val) => controller.materialQtyString.value =val,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              // keyboardType: TextInputType.visiblePassword,
            
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  filled: true,
                  // prefixIcon: Icon(
                  //   Icons.sho,
                  // ),
                  labelText: 'Material Qty'),
            ),
          ),
         
        ],
      ),
    );
  }

  Widget addThirddRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


         Flexible(
            child: Obx(() {
              if (controller.unitList != null)
                return DropdownButtonFormField(
                
                   

                    // isDense: true,

                    decoration: InputDecoration(
                      /* enabledBorder: InputBorder.none that will remove the border and also the upper left 
                  and right cut corner  */
                      contentPadding: EdgeInsets.only(left: 8),
                      /* 
                  
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  */
                      filled: true,
                    ),
                    hint: Text('Select unit'),
                    items: controller.unitList
                        .map((unit) => DropdownMenuItem<String>(
                            value: unit,
                            child: Column(
                              children: [Text(unit)],
                            )))
                        .toList(),
                    onSaved: (String un) =>
                        controller.currUnit.value = un,
                    onChanged: (String unit) {
                      // if (paymentMode.mode == 'Bank-Transfer') {
                      //   showUserDialogue(context, paymentMode);
                      // } else {
                      //   controller.currPaymentModeString.value =
                      //       "Cash"; //check it out

                      //   controller.currBankVal.value = null;
                      // }
                    });

              return Text('loading...');
            }
            ),
          ),



       
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: TextFormField(
              controller: controller.materialUnitPriceTextEditCont,
              onChanged: (unitPric){
controller.materialTotalCostTextEditCont.text=(double.parse(controller.materialQtyTextEditCont.text)*double.parse(unitPric)).toString();


              },
              validator: (val) =>
                  val.isEmpty ? "Plz enter unit price" : null,
              onSaved: (val) => controller.materialUnitPriceString.value =val,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  filled: true,
                  // prefixIcon: Icon(
                  //   Icons.sho,
                  // ),
                  labelText: 'Unit Price'),
            ),
          ),
      ],
    );
  }

  Widget addFourthColumn(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(top:4.0,bottom:20 ),
        child: TextFormField(
          onSaved: (totalCost)=>controller.totalCostStrig.value=totalCost,
          controller: controller.materialTotalCostTextEditCont,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          
          decoration: InputDecoration(
        contentPadding: EdgeInsets.all(4),
        filled: true,
        // prefixIcon: Icon(
        //   Icons.sho,
        // ),
        labelText: 'Total Cost'),
        ),
      ),
      RoundedLoadingButton(
        
      width: Get.context.width*0.4,
      child: Text('Submit', style: TextStyle(color: Colors.white)),
      controller: controller.addMaterialRountButton.value,
      onPressed: () {
        if (controller.addMaterialFormKey.value.currentState
        .validate()) {
      controller.addMaterialFormKey.value.currentState.save();
          controller.addMaterial(context);
        } else
      controller.addMaterialRountButton.value.stop();
      },
    ),
    ],
        );
  }


  

 
}
