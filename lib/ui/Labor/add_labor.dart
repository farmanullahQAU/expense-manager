import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_manager/controllers/paymentController/add_paymentController.dart';
import 'package:expense_manager/controllers/add_labor_controller.dart';
import 'package:expense_manager/models/labor_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddLabor extends GetWidget<AddLaborController> {
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
        title: Text('Add Labor'),
      ),
      body: Container(
        child: Form(
          key: controller.addlaborFormKey.value,
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
            child: Text('Add labor details'),
          ),
          addFirstRow(context),
          addSecondRow(context),
          // addThirddRow(context),
          // addFourthColumn(context),
          addSubmittButton(context)
        ],
      ),
    );
  }

  Widget addFirstRow(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            validator: (val) =>
                val.isNullOrBlank ? "Plz enter labor name" : null,
            onChanged: (value) {
              controller.name.value = value;
            },
            keyboardType: TextInputType.text,

            /* keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 12,
            maxLength: 200,
            // expands: true,
            textInputAction: TextInputAction.newline,
            */
            controller: controller.nameTextController.value,
            decoration: InputDecoration(
                suffixIcon: Obx(() => controller.name.value == "" ||
                        controller.name.value.isNullOrBlank
                    ? Container(width: 0.0, height: 0.0)
                    : IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.nameTextController.value.clear();
                        })),
                contentPadding: EdgeInsets.all(4),

                //  contentPadding: EdgeInsets.all(10),
                filled: true,
                prefixIcon: Icon(Icons.perm_identity),
                labelText: 'Labor-Name'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            controller: controller.addressTextController.value,
            validator: (val) =>
                val.isNullOrBlank ? "Plz enter labor address" : null,
            onChanged: (value) {
              controller.address.value = value;
            },
            onSaved: (value) {
              controller.address.value = value;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                suffixIcon: Obx(() => controller.address.value == '' ||
                        controller.address.value.isNullOrBlank
                    ? Container(width: 0.0, height: 0.0)
                    : IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.laborTypeTextController.value.clear();
                        })),
                contentPadding: EdgeInsets.all(4),

                //  contentPadding: EdgeInsets.all(10),
                filled: true,
                prefixIcon: Icon(Icons.location_city),
                labelText: 'Labor-Address'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InternationalPhoneNumberInput(
            validator: (phone) => phone == "" ? "Plz enter phone no" : null,
            inputDecoration: InputDecoration(
              filled: true,
            ),
            onInputChanged: (PhoneNumber number) {
              controller.number.value = number;
              print(controller.number.value = number);
            },
            onInputValidated: (bool value) {
              controller.isValidPhone.value =
                  value; //valid or invalid phone number
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.DROPDOWN,
              backgroundColor: Colors.black,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(color: Colors.black),
            initialValue: controller.number.value,
            textFieldController: controller.phoneNumberTextController.value,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // SizedBox(
              // //  width: isLandscap(context) ? 10 : 5,
              // ),

              Flexible(
                child: Obx(() {
                  if (controller.laborTypes != null)
                    return DropdownButtonFormField(
                        validator: (val) =>
                            val == null ? "Plz select labor type" : null,

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
                        hint: Text('Labor-Type'),
                        items: controller.laborTypes.map((laborType) {
                          return DropdownMenuItem<LaborTypes>(
                              value: laborType,
                              child: Column(
                                children: [Text(laborType.laborType)],
                              ));
                        }).toList(),
                        onChanged: (LaborTypes laborType) {
                          controller.currLaborType.value = laborType;
                        });
                  return Center(child: CircularProgressIndicator());
                }),
              ),
            ],
          ),
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
              controller: controller.amountTextEditingController,
              validator: (val) =>
                  val.isEmpty ? "Plz enter daily wage/contract amount" : null,
              onSaved: (val) => controller.amount.value = double.parse(val),
              maxLength: 9,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.attach_money,
                  ),
                  labelText: 'Daily Wage/Contract-Amount'),
            ),
          ),
          SizedBox(
            width: context.isLandscape ? 10 : 5,
          ),
          Flexible(
            child: Obx(() {
              if (controller.paymentTypes != null)
                return DropdownButtonFormField(
                    validator: (val) =>
                        val == null ? "Plz select payment type" : null,

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
                    hint: Text('Payment-Type'),
                    items: controller.paymentTypes
                        .map((paymentType) => DropdownMenuItem<String>(
                            value: paymentType,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [Text(paymentType)],
                            )))
                        .toList(),
                    onChanged: (String paymentType) {
                      if (paymentType == 'Contract-Base') {
                        showContractDialog(context, paymentType);
                      } else {
                        controller.currPaymentType.value = "Daily-Wage-Base";
                        controller.contract.value = null;

                        //   controller.currPaymentType.value="Daily_Wage_base";

                      }
                    });

              return Text('loading...');
            }),
          ),
        ],
      ),
    );
  }

  // Widget addThirddRow(BuildContext context) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Flexible(
  //         fit: FlexFit.loose,
  //         child: Obx(() {
  //           if (controller.transactionModeList != null)
  //             return DropdownButtonFormField(
  //                 validator: (val) =>
  //                     val == null ? "Plz select Transaction mode" : null,

  //                 // isDense: true,

  //                 decoration: InputDecoration(
  //                   /* enabledBorder: InputBorder.none that will remove the border and also the upper left
  //               and right cut corner  */
  //                   contentPadding: EdgeInsets.only(left: 8),
  //                   /*

  //               border: OutlineInputBorder(
  //                 borderSide: BorderSide.none,
  //               ),
  //               */
  //                   filled: true,
  //                 ),
  //                 hint: Text('Transaction Mode'),
  //                 items: controller.transactionModeList
  //                     .map((transaction) => DropdownMenuItem<TransactionMode>(
  //                         value: transaction,
  //                         child: Column(
  //                           children: [Text(transaction.transactionMode)],
  //                         )))
  //                     .toList(),
  //                 onChanged: (tranType) {
  //                   controller.currTransactionMode.value = tranType;
  //                 });

  //           return Text('loading...');
  //         }),
  //       ),
  //       SizedBox(
  //         width: 5,
  //       ),
  //       Flexible(
  //         child: Obx(() {
  //           if (controller.transactionTypeList != null)
  //             return DropdownButtonFormField(
  //                 validator: (val) =>
  //                     val == null ? "Plz select transaction type" : null,

  //                 // isDense: true,

  //                 decoration: InputDecoration(
  //                   /* enabledBorder: InputBorder.none that will remove the border and also the upper left
  //               and right cut corner  */
  //                   contentPadding: EdgeInsets.only(left: 8),
  //                   /*

  //               border: OutlineInputBorder(
  //                 borderSide: BorderSide.none,
  //               ),
  //               */
  //                   filled: true,
  //                 ),
  //                 hint: Text('Transaction Type'),
  //                 items: controller.transactionTypeList
  //                     .map((transaction) => DropdownMenuItem<TransactionsType>(
  //                         value: transaction,
  //                         child: Column(
  //                           children: [Text(transaction.transactionType)],
  //                         )))
  //                     .toList(),
  //                 onChanged: (tranType) {
  //                   controller.currTransactionType.value = tranType;
  //                 });

  //           return Text('loading...');
  //         }),
  //       ),
  //     ],
  //   );
  // }

  // Widget addFourthColumn(BuildContext context) {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(top: 8.0),
  //         child: TextFormField(
  //           validator: (val) =>
  //               val.isNullOrBlank ? "Plz enter labor name" : null,

  //           onChanged: (value) {
  //             controller.paymentDescContString.value = value;
  //           },
  //           keyboardType: TextInputType.multiline,
  //           minLines: 1,
  //           maxLines: 12,
  //           maxLength: 200,
  //           // expands: true,
  //           textInputAction: TextInputAction.newline,
  //           controller: controller.paymentDesTextEditingController,
  //           decoration: InputDecoration(
  //               suffixIcon: Obx(() =>
  //                   controller.paymentDescContString.value?.length == null ||
  //                           controller.paymentDescContString.value == ''
  //                       ? Container(width: 0.0, height: 0.0)
  //                       : IconButton(
  //                           icon: Icon(Icons.clear),
  //                           onPressed: () {
  //                             controller.paymentDesTextEditingController
  //                                 .clear();
  //                           })),
  //               contentPadding: EdgeInsets.all(4),

  //               //  contentPadding: EdgeInsets.all(10),
  //               filled: true,
  //               prefixIcon: Icon(Icons.add_business),
  //               labelText: 'Payment-Name'),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 8.0),
  //         child: TextFormField(
  //           validator: (val) =>
  //               val.isNullOrBlank ? "Plz enter labor address" : null,

  //           onChanged: (value) {
  //             controller.paymentDescContString.value = value;
  //           },
  //           keyboardType: TextInputType.multiline,
  //           minLines: 1,
  //           maxLines: 12,
  //           maxLength: 200,
  //           // expands: true,
  //           textInputAction: TextInputAction.newline,
  //           controller: controller.paymentDesTextEditingController,
  //           decoration: InputDecoration(
  //               suffixIcon: Obx(() =>
  //                   controller.paymentDescContString.value?.length == null ||
  //                           controller.paymentDescContString.value == ''
  //                       ? Container(width: 0.0, height: 0.0)
  //                       : IconButton(
  //                           icon: Icon(Icons.clear),
  //                           onPressed: () {
  //                             controller.paymentDesTextEditingController
  //                                 .clear();
  //                           })),
  //               contentPadding: EdgeInsets.all(4),

  //               //  contentPadding: EdgeInsets.all(10),
  //               filled: true,
  //               prefixIcon: Icon(Icons.add_business),
  //               labelText: 'Labor-Address'),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 8.0),
  //         child: TextFormField(
  //           validator: (val) =>
  //               val.isNullOrBlank ? "Plz enter labor phone no" : null,

  //           onChanged: (value) {
  //             controller.paymentDescContString.value = value;
  //           },
  //           keyboardType: TextInputType.multiline,
  //           minLines: 1,
  //           maxLines: 12,
  //           maxLength: 200,
  //           // expands: true,
  //           textInputAction: TextInputAction.newline,
  //           controller: controller.paymentDesTextEditingController,
  //           decoration: InputDecoration(
  //               suffixIcon: Obx(() =>
  //                   controller.paymentDescContString.value?.length == null ||
  //                           controller.paymentDescContString.value == ''
  //                       ? Container(width: 0.0, height: 0.0)
  //                       : IconButton(
  //                           icon: Icon(Icons.clear),
  //                           onPressed: () {
  //                             controller.paymentDesTextEditingController
  //                                 .clear();
  //                           })),
  //               contentPadding: EdgeInsets.all(4),

  //               //  contentPadding: EdgeInsets.all(10),
  //               filled: true,
  //               prefixIcon: Icon(Icons.add_business),
  //               labelText: 'Labor-Phone'),
  //         ),
  //       ),
  //       Container(
  //           width: context.width - 0.2,
  //           child: RoundedLoadingButton(
  //             child: Text('Add Labor', style: TextStyle(color: Colors.white)),
  //             controller: controller.roundLoadingAdddPaymentContr.value,
  //             onPressed: () {
  //               if (controller.addPaymentFormKey.value.currentState
  //                   .validate()) {
  //                 controller.addPaymentFormKey.value.currentState.save();
  //                 controller.addPayment();
  //               } else
  //                 controller.roundLoadingAdddPaymentContr.value.stop();
  //             },
  //           )),
  //     ],
  //   );
  // }

  showContractDialog(BuildContext context, String paymentType) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false, //enable and disable outside click
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: <Widget>[
          Row(
            children: [
              RaisedButton(
                color: Theme.of(context).primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  if (controller.contractDetailsFormKey.value.currentState
                      .validate()) {
                    controller.contractDetailsFormKey.value.currentState.save();
                    controller.currPaymentType.value = paymentType;
                  }
                },
                child: Text(
                  "Ok",
                ),
              ),
              RaisedButton(
                color:
                    Get.isDarkMode ? Theme.of(context).accentColor : Colors.red,

                //  color: Theme.of(context).primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  controller.contract.value = null;
                  controller.currPaymentType.value = "Daily-Wage-Base";

                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Get.isDarkMode ? null : Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text('Contract details'),
        content: SingleChildScrollView(
          child: Form(
              key: controller.contractDetailsFormKey.value,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.contractNameTextController.value,
                    validator: (val) =>
                        val.isEmpty ? "Please enter contract name" : null,

                    /* set contract object value when user clicks of ok */
                    /*set contract name*/
                    onSaved: (contractName) =>
                        controller.contract.value.contractName =
                            controller.contractNameTextController.value.text,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4),
                        filled: true,
                        prefixIcon: Icon(Icons.perm_identity),
                        labelText: 'Contract-Name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      controller:
                          controller.contractDetailsTextController.value,
                      validator: (val) =>
                          val.isEmpty ? "Please enter contract details" : null,
                      onSaved: (contractDetails) =>
                          /* set description */
                          controller.contract.value.description = controller
                              .contractDetailsTextController.value.text,
                      maxLength: 100,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.note,
                          ),
                          labelText: 'Contract-details'),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  addSubmittButton(BuildContext context) {
    return Container(
        width: context.width - 0.2,
        child: RoundedLoadingButton(
          child: Text('Add Labor', style: TextStyle(color: Colors.white)),
          controller: controller.roundLoadingAddLabor.value,
          onPressed: () {
            if (controller.addlaborFormKey.value.currentState.validate() &&
                controller.isValidPhone.value == true) {
              controller.addlaborFormKey.value.currentState.save();
              controller.addLabor();
            } else if (controller.isValidPhone.value == false) {
              Get.defaultDialog(
                middleText: 'Invalid Phone#',
                barrierDismissible: false,
                confirmTextColor: Get.isDarkMode
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                onConfirm: () {
                  Get.back();
                },
                title: 'Warning!',
                radius: 8.0,
              );
              controller.roundLoadingAddLabor.value.stop();
            }
          },
        ));
  }

  // showUserSelectVendorDialog(BuildContext context, PaymentType paymentType) {
  //   showDialog(
  //     //barrierDismissible: false, //enable and disable outside click
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       actions: <Widget>[
  //         FlatButton(
  //           color: Colors.greenAccent,
  //           onPressed: () {},
  //           child: Text('SAVE'),
  //         ),
  //         FlatButton(
  //           color: Colors.redAccent,
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: Text('Cancel'),
  //         ),
  //       ],
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       title: Text('Select Vendor'),
  //       content: SingleChildScrollView(
  //         child: Form(
  //           // key: formKey,
  //           child: Obx(
  //             () {
  //               if (controller.vendorList != null) {
  //                 return Container(
  //                   width: 200,
  //                   height: 200,
  //                   child: ListView.separated(
  //                     itemBuilder: (BuildContext context, int index) {
  //                       Vendor vendor = controller.vendorList[index];
  //                       return Obx(() => ListTile(
  //                             selectedTileColor: Theme.of(context).primaryColor,
  //                             selected: index ==
  //                                 controller.vendorListCurrentIndex.value,

  //                             // leading: CachedNetworkImage(
  //                             //   placeholder: (BuildContext context, _) =>
  //                             //       CircularProgressIndicator(),
  //                             //   imageUrl: bank.logoUrl.toString(),
  //                             //   errorWidget: (context, url, error) =>
  //                             //       Text("logo..."),
  //                             //   imageBuilder: (context, imageProvider) =>
  //                             //       CircleAvatar(
  //                             //     backgroundColor: Colors.white,
  //                             //     backgroundImage: imageProvider,
  //                             //   ),
  //                             // ),
  //                             title: Text(vendor.name),

  //                             trailing: Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(vendor.name),
  //                                 Text(vendor.address),
  //                               ],
  //                             ),
  //                             onTap: () {
  //                               print('selected vendor');
  //                               controller.currVendor.value =
  //                                   controller.vendorList[index];
  //                               controller.vendorListCurrentIndex.value = index;

  //                               controller.currPaymentType.value =
  //                                   paymentType; /* set currPayment Type*/
  //                             },
  //                           ));
  //                     },
  //                     itemCount: controller.vendorList.length,
  //                     separatorBuilder: (BuildContext context, int index) {
  //                       return Divider();
  //                     },
  //                   ),
  //                 );
  //               }
  //               return Text('loading.....');
  //             },
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
