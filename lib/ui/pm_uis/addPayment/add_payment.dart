import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_manager/controllers/paymentController/add_paymentController.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';

class AddPayment extends GetWidget<AddPaymentController> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  var userController = Get.put(UsrController());

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
        title: Text('Add Payment'),
      ),
      body: Container(
        child: Form(
          // key: controller.getformKey,
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text('Add Project Details'),
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
            if (controller.getPaymentTypeList != null)
              return DropdownButtonFormField(
                  validator: (val) =>
                      val == null ? "Plz select Payment Type" : null,

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
                  hint: Text('Payment Type'),
                  items: controller.getPaymentTypeList.map((payType) {
                    return DropdownMenuItem<PaymentType>(
                        value: payType,
                        child: Column(
                          children: [Text(payType.paymentType)],
                        ));
                  }).toList(),
                  onChanged: (PaymentType paymentType) {
                    if (paymentType.paymentType == 'Customer-Vendor' ||
                        paymentType.paymentType == 'Pm_Vendor')
                      showUserSelectVendorDialog(context);
                    else
                      controller.setcurrPaymentType = paymentType;
                  });
            return Text('loading...');
          }),
        ),
        SizedBox(
          width: context.isLandscape ? 10 : 5,
        ),
        Flexible(
          child: Obx(() {
            if (controller.getProjectLIst != null)
              return DropdownButtonFormField(
                  validator: (val) => val == null ? "Plz select project" : null,

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
                  hint: Text('Select Project'),
                  items: controller.getProjectLIst
                      .map((projectObj) => DropdownMenuItem<Project>(
                          value: projectObj,
                          child: Column(
                            children: [Text(projectObj.customerRelation)],
                          )))
                      .toList(),
                  onChanged: (contract) {
                    controller.setCurrSelProj = contract;
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
              // controller: controller.estimatedCostController,
              validator: (val) =>
                  val.isEmpty ? "Plz enter estimated cost" : null,
              onSaved: (val) => controller.setAmount = double.parse(val),
              maxLength: 9,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(

                  // isDense: true,

                  // enabledBorder: InputBorder.none,
                  // border: InputBorder.none,

                  /*  prefixIconConstraints: BoxConstraints(
                    minHeight: context.isLandscape ? 200 : 5,
                    minWidth: context.isLandscape ? 200 : 5,
                  ),
                  controll the input filed width and height 
                  */
                  contentPadding: EdgeInsets.all(4),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.attach_money,
                  ),
                  labelText: 'Totoal Amount'),
            ),
          ),
          SizedBox(
            width: context.isLandscape ? 10 : 5,
          ),
          Flexible(
            child: Obx(() {
              if (controller.getPaymentModeList != null)
                return DropdownButtonFormField(
                    validator: (val) =>
                        val == null ? "Plz select payment mode" : null,

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
                    hint: Text('Select Mode'),
                    items: controller.getPaymentModeList
                        .map((paymode) => DropdownMenuItem<PaymentMode>(
                            value: paymode,
                            child: Column(
                              children: [Text(paymode.mode)],
                            )))
                        .toList(),
                    onChanged: (PaymentMode paymentMode) {
                      if (paymentMode.mode == 'Bank-Transfer') {
                        showUserDialogue(context);
                      } else {
                        controller.setcurrPaymentMode = paymentMode;
                      }
                    });

              return Text('loading...');
            }),
          ),
        ],
      ),
    );
  }

  Widget addThirddRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        // //  width: isLandscap(context) ? 10 : 5,
        // ),

        Flexible(
          child: Obx(() {
            if (controller.getTransactionModeList != null)
              return DropdownButtonFormField(
                  validator: (val) =>
                      val == null ? "Plz select Transaction mode" : null,

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
                  hint: Text('Transaction Mode'),
                  items: controller.getTransactionModeList
                      .map((transaction) => DropdownMenuItem<TransactionMode>(
                          value: transaction,
                          child: Column(
                            children: [Text(transaction.transactionMode)],
                          )))
                      .toList(),
                  onChanged: (tranType) {
                    controller.setcurrPaymentMode = tranType;
                  });

            return Text('loading...');
          }),
        ),

        SizedBox(
          width: context.isLandscape ? 10 : 5,
        ),
        Flexible(
          child: Obx(() {
            if (controller.getTransactionTypeList != null)
              return DropdownButtonFormField(
                  validator: (val) =>
                      val == null ? "Plz select transaction type" : null,

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
                  hint: Text('Transaction Type'),
                  items: controller.getTransactionTypeList
                      .map((transaction) => DropdownMenuItem<TransactionsType>(
                          value: transaction,
                          child: Column(
                            children: [Text(transaction.transactionType)],
                          )))
                      .toList(),
                  onChanged: (tranType) {
                    controller.setCurrTransactionType = tranType;
                  });

            return Text('loading...');
          }),
        ),
      ],
    );
  }

  Widget addFourthColumn(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (val) =>
              val.isNullOrBlank ? "Plz enter customer relation details" : null,

          onChanged: (value) {
            // controller.setRelationString = value;

            //  print(controller.getRelationString);
          },
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 12,
          maxLength: 200,
          // expands: true,
          textInputAction: TextInputAction.newline,
          controller: controller.paymentDescTextEditingController,
          decoration: InputDecoration(
              suffixIcon: Obx(() =>
                  controller.getPaymentDescString?.length == null ||
                          controller.getPaymentDescString == ''
                      ? Container(width: 0.0, height: 0.0)
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            //   controller.remarksController.clear();
                          })),
              contentPadding: EdgeInsets.all(4),

              //  contentPadding: EdgeInsets.all(10),
              filled: true,
              prefixIcon: Icon(Icons.add_business),
              labelText: 'Customer Relation'),
        ),
        SizedBox(
            //   width: isLandscap(context) ? 10 : 5,
            ),
        Container(
            width: context.width - 0.2,
            child: FlatButton(
                textColor: Get.isDarkMode ? null : Colors.white,
                child: Text('Add Project'),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (controller.getformKey.currentState.validate()) {
                    controller.getformKey.currentState.save();
                    CircularProgressIndicator();
                  }
                }))
      ],
    );
  }

  Widget projectDialog(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  tooltip: 'Add Student',
                  child: Icon(Icons.add),
                  onPressed: () {
                    // showUserDialogue(context, isUpdate, student);
                  }),
            ],
          ),
          // showUserDialogue(context)
        ],
      ),
    );
  }

  showUserDialogue(BuildContext context) {
    showDialog(
      //barrierDismissible: false, //enable and disable outside click
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.greenAccent,
            onPressed: () {},
            child: Text('SAVE'),
          ),
          FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Select Account'),
        content: SingleChildScrollView(
          child: Form(
            // key: formKey,
            child: Obx(
              () {
                if (controller.getBanAccountList != null) {
                  return Container(
                    width: 200,
                    height: 200,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        Bank bank = controller.getBanAccountList[index];
                        return Obx(() => ListTile(
                              selectedTileColor: Theme.of(context).primaryColor,
                              selected:
                                  index == controller.getAccountNoListCurrIndex,

                              leading: CachedNetworkImage(
                                placeholder: (BuildContext context, _) =>
                                    CircularProgressIndicator(),
                                imageUrl: bank.logoUrl.toString(),
                                errorWidget: (context, url, error) =>
                                    Text("logo..."),
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: imageProvider,
                                ),
                              ),
                              // title: Text(bank.bankName),
                              // subtitle: Text(bank.branch),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(bank.accountNo),
                                  Text(bank.bankName),
                                ],
                              ),
                              onTap: () {
                                controller.setAccountNoListCurrIndex = index;
                                controller.setCurrBank =
                                    controller.getBanAccountList[index];
                              },
                            ));
                      },
                      itemCount: controller.getBanAccountList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    ),
                  );
                }
                return Text('loading.....');
              },
            ),
          ),
        ),
      ),
    );
  }

  showUserSelectVendorDialog(BuildContext context) {
    showDialog(
      //barrierDismissible: false, //enable and disable outside click
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.greenAccent,
            onPressed: () {},
            child: Text('SAVE'),
          ),
          FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Select Vendor'),
        content: SingleChildScrollView(
          child: Form(
            // key: formKey,
            child: Obx(
              () {
                if (controller.getVendorList != null) {
                  return Container(
                    width: 200,
                    height: 200,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        Vendor vendor = controller.getVendorList[index];
                        return Obx(() => ListTile(
                              selectedTileColor: Theme.of(context).primaryColor,
                              selected:
                                  index == controller.getVendorListCurrentIndex,

                              // leading: CachedNetworkImage(
                              //   placeholder: (BuildContext context, _) =>
                              //       CircularProgressIndicator(),
                              //   imageUrl: bank.logoUrl.toString(),
                              //   errorWidget: (context, url, error) =>
                              //       Text("logo..."),
                              //   imageBuilder: (context, imageProvider) =>
                              //       CircleAvatar(
                              //     backgroundColor: Colors.white,
                              //     backgroundImage: imageProvider,
                              //   ),
                              // ),
                              title: Text(vendor.name),

                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(vendor.name),
                                  Text(vendor.address),
                                ],
                              ),
                              onTap: () {
                                print('selected vendor');
                                controller.setcurrVendor =
                                    controller.getVendorList[index];
                                controller.setVendorListCurrentIndex = index;
                                print(controller.getcurrVendor.name);
                              },
                            ));
                      },
                      itemCount: controller.getVendorList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    ),
                  );
                }
                return Text('loading.....');
              },
            ),
          ),
        ),
      ),
    );
  }
}