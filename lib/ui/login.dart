import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pm_uis/pm_home.dart';

class LoginUi extends GetWidget {
  //final NoteController noteController = Get.put(NoteController());
  final AuthController authController = Get.put(AuthController());
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.looks_two),
                    onPressed: () {
                      Get.find<AuthController>().logout();
                    }),
                IconButton(
                    icon: Icon(Icons.lightbulb_outline),
                    onPressed: () {
                      Get.isDarkMode
                          ? Get.changeTheme(ThemeData.light())
                          : Get.changeTheme(ThemeData.dark());
                    })
              ],
              //  backgroundColor: Colors.teal,
              title: Text('Login '),
            ),
            body: _buildContainer(context)));
  }

  Widget _buildContainer(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Log in",
                        ),
                      ],
                    ),
                  ],
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
                  obscureText: true,
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
                          authController.login(
                              emailController.text, passwordController.text);

                          // Get.to(HomePage());
                        },
                        child: Text('Login'))
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
