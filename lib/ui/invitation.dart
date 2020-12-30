import 'package:flutter/material.dart';
import 'package:expense_manager/controllers/invitationController.dart';
import 'dart:async';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter_sms/flutter_sms.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class Invitation extends GetWidget<InvitationController>{
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
        appBar: AppBar(
          title: const Text('SMS'),
        ),
        body: 
                   
                                      Center(
                                        child: Container(
                                          width: context.width*0.8,
                                          height: context.height,
                                          child: ListView(
            children: <Widget>[
          

             Obx(()=>
                             controller. people == null || controller.people.isEmpty
                      ? Container(
                          height: 0.0,
                        )
                      : Container(
                          height: 90.0,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children:
                                  List<Widget>.generate(controller.people.length, (int index) {
                                return _phoneTile(controller.people[index]);
                              }),
                            ),
                          ),
                        ),
             ),

              Padding(padding: EdgeInsets.only(top: 30.0)),

                            Container(
                     padding:
                      EdgeInsets.only(left: 0.0, right: 10.0, top: 0.0, bottom: 0.0),

                  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                          boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.grey[300])]),
                                          child: InternationalPhoneNumberInput(
                                          
            validator: (phone) => phone == "" ? "Plz enter phone no" : null,
           
              inputDecoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: (){

                 if(controller.phoneNumberTextController.value.text.isEmpty)
                 {
                   return null;
                 }
                 else{
                   return controller.people.add(controller.number.toString());
                 }
                  },
                  icon: Icon(Icons.group_add)),
                     contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0 ),

                      border: InputBorder.none,
                      
                      
                    ),
            onInputChanged: (PhoneNumber number) {
              controller.number.value = number;
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
              Padding(padding: EdgeInsets.only(top: 8.0)),
             

                Container(
                  width: context.width*0.8,
                      padding:
                      EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                          boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.grey[300])]),
                      child: TextFormField(
            keyboardType: TextInputType.multiline,
                         minLines: 1,
            maxLines: 12,
            maxLength: 200,
            textInputAction: TextInputAction.newline,
                        

                                  controller:controller. controllerMessage.value,

                        // validator: (val) {
                        //   return val != '' ? null : 'Eter message';
                        // },
                        decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0 ),
                    border: InputBorder.none,
                    isDense: false,
                    counterText: "",
                    
                    icon: const Icon(
                      Icons.message,
                    ),
                    labelText: "Message",
                  ),
                        onChanged: (value) {
                          controller.controllerMessage.value.text=value;
                        },
                      )
                  ),
            
              
             
              // ListTile(
              //   title: Text("Can send SMS"),
              //   subtitle: Text(controller.canSendSMSMessage.value),
              //   trailing: IconButton(
              //     padding: EdgeInsets.symmetric(vertical: 16),
              //     icon: Icon(Icons.check),
              //     onPressed: () {
              //     // controller. canISendSMS();
              //     },
              //   ),
              // ),
              SizedBox(
                width:10,
                
                child: Padding(
                  padding: const EdgeInsets.only(top:12.0),
                  child: RaisedButton(
                    
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                    child: Text("SEND",
                          style: Theme.of(context).accentTextTheme.button),
                    onPressed: () {
                      if(controller.isValidPhone.value==false)
                      {
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


                      }
                      else
                    
                       controller. send();
                    },
                  ),
                ),
              ),
              Obx(()=>
                                 Visibility(
                  visible: controller.message.value != null,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              controller.message.value?? "No Data",
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],
                  ),
                ),
              ),
            ],
          ),
                                        ),
                                      ),
                  
      
      );
  }

  Widget _phoneTile(String name) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[300]),
            top: BorderSide(color: Colors.grey[300]),
            left: BorderSide(color: Colors.grey[300]),
            right: BorderSide(color: Colors.grey[300]),
          )),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller. people.remove(name),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    name,
                    textScaleFactor: 1.0,
                    style: TextStyle(fontSize: 12.0),
                  ),
                )
              ],
            ),
          )),
    );
  }
  


}

// The existing imports
// !! Keep your existing impots here !!

/// main is entry point of Flutter application


/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.


