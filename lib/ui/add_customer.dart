import 'package:expense_manager/controllers/authController/auth_controller.dart';

import 'package:expense_manager/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pm_uis/pm_home.dart';
import 'package:expense_manager/controllers/AddCustPmController.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddCustomer extends GetWidget<AddCustomerOrpmController> {
 

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
                  Get.find<AuthController>().logout();
                })
          ],
          //  backgroundColor: Colors.teal,
          title: Text('Add Customer'),
        ),
        body: _buildContainer(context),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Center(
      child: Form(
        key: controller.formKey.value,
              child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              
                      width: MediaQuery.of(context).size.width*.8,
                      height: MediaQuery.of(context).size.width*.9,

              
              child: ListView(
                children: [


                
                  
                 
                  
                
                  Container(
                      padding:
                      EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white,
                          boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.grey[300])]),
                      child: TextFormField(
                        

                                  controller:controller. nameController,

                        validator: (val) {
                          return val != '' ? null : 'Enter name';
                        },
                        decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0 ),
                    border: InputBorder.none,
                    isDense: false,
                    counterText: "",
                    
                    icon: const Icon(
                      Icons.person,
                    ),
                    labelText: "Name",
                  ),
                        onSaved: (value) {
                          controller.nameController.text=value;
                        },
                      )
                  ),
                          Padding(padding: EdgeInsets.only(top: 3.0)),

                  // Positioned(
                  //     right: 10.0,
                  //     top: 3.0,
                  //     //alignment: Alignment.topRight,
                  //     child: Tooltip(
                  //         message: "Libreta de contactos",
                  //         child: _buildSelectContactButton(context, Icons.perm_contact_calendar, Colors.white)
                  //     )
                  // ),

                    Container(
                            padding:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black12)]),

                            child: TextFormField(
                            
                            controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    return val != '' ? null : 'Enter email';
                  },
                  decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0 ),

                    
                    border: InputBorder.none,
                    isDense: false,
                    counterText: "",
                    icon: const Icon(
                      Icons.email,
                    ),
                    labelText: "Email",
                  ),
                  onSaved: (value) {
                    controller.emailController.text=value;
                  },
                            ),
                          ),
                        


                          Padding(padding: EdgeInsets.only(top: 3.0)),
                           Container(
                            padding:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.white,
                                boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black12)]),

                            child: TextFormField(
                              obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller:controller. passwordController,
                    obscuringCharacter: "*",
                              validator: (val) {
                                return val != '' ? null : 'Enter Password';
                              },
                              decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0 ),

                                border: InputBorder.none,
                                isDense: false,
                                counterText: "",
                                icon: const Icon(
                                  Icons.lock,
                                ),
                                labelText: "Password",
                              ),
                              onSaved: (value) {
                                controller.passwordController.text=value;
                              //  guestName = value;
                              },
                            ),
                          ),
                          

                            Padding(padding: EdgeInsets.only(top: 3.0)),
                           Container(
                            padding:
                            EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.white,
                                boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black12)]),

                            child: TextFormField(
                              controller:controller. addresController,
                          
                    obscuringCharacter: "*",
                              validator: (val) {
                                return val != '' ? null : 'Enter Address';
                              },
                              decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0 ),

                                border: InputBorder.none,
                                isDense: false,
                                counterText: "",
                                icon: const Icon(
                                  Icons.store_mall_directory,
                                ),
                                labelText: "Address",
                              ),
                              onSaved: (value) {
                                controller.addresController.text=value;
                              //  guestName = value;
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 3.0)),

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
                          
                          // buttonCustom(
                          //   color: Color(0xFF4458be),
                          //   heigth: 50.0,
                          //   txt: "Agregar",
                          //   ontap: () {
                          //     print(phoneTextFieldController.text);
                          //   },
                          // ),
                            Row(
                    children: [
                      FlatButton(
                  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
  //side: BorderSide(color: Colors.white)
), 
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                          onPressed: () {
                            if(controller.formKey.value.currentState.validate() &&
                controller.isValidPhone.value == true
                            
                            
                            
                            )
                            {

                              controller.formKey.value.currentState.save();
                              controller.addUsr();
                            }

                            else if (controller.isValidPhone.value == false) {
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
                          
                          },
                          child: Text('Add')),
                          FlatButton(
                            textColor:Get.isDarkMode?Theme.of(context).primaryColor:Colors.green,
                            
                            child: Text('Send Invitation'),onPressed: (){
                              Get.toNamed('invitationUi');



                          },)
                    ],
                  ),
                        ],
                      )
            
                
              ),
          ],
        ),
      ),
    );
    
  }
  RawMaterialButton _buildSelectContactButton(BuildContext context ,IconData iconButton, Color colorButton) {

    return RawMaterialButton(
      constraints: const BoxConstraints(
          minWidth: 40.0, minHeight: 40.0
      ),
      onPressed: () => {
      //  _showContactList(context)

      },
      child: Icon(
        // Conditional expression:
        // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
        iconButton,
        color: Theme.of(context).primaryColorLight,
      ),
      elevation: 0.5,
      fillColor: colorButton,
      shape: CircleBorder(),
    );



  
}}
