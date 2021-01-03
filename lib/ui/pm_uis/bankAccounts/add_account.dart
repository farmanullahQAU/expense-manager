import 'package:expense_manager/controllers/BankAccountController/add_bank_acc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddBankAccount extends GetWidget<AddBankAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add account')),
      body: Container(
        child: Form(
          key: controller.addAccountFormKey.value,
          child: addForm(context),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    );
  }

  Widget addForm(BuildContext context) {
    return SingleChildScrollView(
      child: bankNameAndBrankRow(context),
    );
  }

  Widget bankNameAndBrankRow(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButtonFormField(
            isExpanded: true,
            validator: (val) => val == null ? "Select Bank Please" : null,

            // isDense: true,

            decoration: InputDecoration(
              /* enabledBorder: InputBorder.none that will remove the border and also the upper left 
                and right cut corner  */
              contentPadding: EdgeInsets.only(left: 4),
              /* 
                
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                */
              filled: true,
            ),
            hint: Text('Select Bank'),
            items: controller.banks
                .map((bank) => DropdownMenuItem<Map<String, dynamic>>(
                    value: bank,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          child: new Text(bank['bankName'],
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    )))
                .toList(),
            onChanged: (currBank) {
              controller.bankName.value = currBank['bankName'];
              controller.logUrl.value = currBank['logoUrl'];
            }),

        // TextFormField(
        //   validator: (val) =>
        //       val.isNullOrBlank ? "Plz enter bank branch" : null,

        //   onChanged: (value) {
        //     controller.bankBranch.value = value;
        //   },
        //   keyboardType: TextInputType.multiline,
        //   minLines: 1,
        //   maxLines: 1,
        //   maxLength: 10,

        //   // expands: true,
        //   textInputAction: TextInputAction.newline,

        //   decoration: InputDecoration(
        //       contentPadding: EdgeInsets.all(4),

        //       //  contentPadding: EdgeInsets.all(10),
        //       filled: true,
        //       prefixIcon: Icon(Icons.comment),
        //       suffixIcon: Obx(() => controller.bankBranch.value == null ||
        //               controller.bankBranch.value == ''
        //           ? Container(width: 0.0, height: 0.0)
        //           : IconButton(
        //               icon: Icon(Icons.clear),
        //               onPressed: () {
        //                 controller.bankBranchTextEditingController.clear();
        //               })),
        //       labelText: 'Bank Branch'),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            controller: controller.bankAccountTextEditingController,
            validator: (val) => val.isEmpty ? "Plz enter bank account" : null,
            onSaved: (val) => controller.accountNo.value = val,
            maxLength: 9,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(4),
                filled: true,
                prefixIcon: Icon(
                  Icons.attach_money,
                ),
                labelText: 'Account Number'),
          ),
        ),
        Container(
            width: context.width - 0.2,
            child: RoundedLoadingButton(
              color: Theme.of(context).primaryColor,
              child: Text('Add Account', style: TextStyle(color: Colors.white)),
              controller: controller.roundLoadingAddAccount.value,
              onPressed: () async {
                if (controller.addAccountFormKey.value.currentState
                    .validate()) {
                  controller.addAccountFormKey.value.currentState.save();
                  await controller.addAccount();
                  if (controller.isExists.value == true) {
                    Get.snackbar('!Alert',
                        'Account Already exists in this bank', //show snakbar
                        backgroundColor: Theme.of(context).primaryColor,
                        borderRadius: 0,
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    Get.snackbar('Success',
                        'Bank Account added successfully', //show snakbar
                        backgroundColor: Theme.of(context).primaryColor,
                        borderRadius: 0,
                        snackPosition: SnackPosition.BOTTOM);
                  }

                  controller.roundLoadingAddAccount.value
                      .reset(); //reset the button

                } else
                  controller.roundLoadingAddAccount.value
                      .stop(); //stop when form is not valid
              },
            )),
      ],
    );
  }
}
