import 'package:expense_manager/controllers/authController/auth_controller.dart';

import 'package:expense_manager/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pm_uis/pm_home.dart';

class AddCustomer extends GetWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 400,
            width: 300,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Register",
                        ),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      labelText: 'Name'),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      labelText: 'Email'),
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: addresController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                      ),
                      labelText: 'address'),
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: phoneController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                      ),
                      labelText: 'phone'),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                      ),
                      labelText: 'password'),
                ),
                Row(
                  children: [
                    FlatButton(
                        onPressed: () {
                          _authController.createUser(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              adrs: addresController.text,
                              ph: phoneController.text,
                              usrType: "Customer");
                        },
                        child: Text('signup'))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
