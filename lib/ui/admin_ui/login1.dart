import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Login1 extends GetWidget<AuthController> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String email, password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,

        body: Stack(
          children: [
            Container(
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blue, Colors.green]))
                //       ? context.height * 0.4
                //       : context.height * 0.3,
                //   decoration: BoxDecoration(
                //     boxShadow: const <BoxShadow>[
                //       BoxShadow(
                //         offset: Offset(0, 20),
                //         color: Color(0x66000000),
                //         blurRadius: 10,
                //         spreadRadius: 2.0,
                //       )
                //     ],
                //     color: Theme.of(context).primaryColor,
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: const Radius.circular(60),
                //       bottomRight: const Radius.circular(60),
                //     ),
                //   ),
                ),
            ListView(
              children: [
                _buildLogo(context),
                _buildContainer(context),
              ],
            ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 25,
              color:
                  Get.isDarkMode ? Theme.of(context).accentColor : Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              child: Container(
                width: context.isPortrait
                    ? context.width * 0.8
                    : context.width * 0.8,
                height: context.isPortrait
                    ? context.width * 0.9
                    : context.width * 0.4,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? null : Colors.grey[300],
                ),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[],
                        ),
                        Form(
                          key: controller.loginFormKey.value,
                          child: Column(
                            children: [
                              _buildEmailRow(),
                              _buildPasswordRow(),
                            ],
                          ),
                        ),
                        //  _buildForgetPasswordButton(),
                        _buildLoginButton(context),
                        //  _buildOrRow(),
                        // _buildSocialBtnRow(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSocialBtnRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[Text('ddd')],
  //   );
  // }

  /*Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          // margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OR -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
  */

  Widget _buildLoginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 150,
            margin: EdgeInsets.only(top: 50),
            child: RoundedLoadingButton(
              width: 150,
              child: Text('Login',
                  style: TextStyle(
                      color: Get.isDarkMode
                          ? Theme.of(context).accentColor
                          : Colors.white)),
              controller: controller.roundLoadingLoginContr.value,
              onPressed: () {
                if (controller.loginFormKey.value.currentState.validate()) {
                  controller.loginFormKey.value.currentState.save();
                  controller.login(
                      emailController.text, passwordController.text);
                } else
                  controller.roundLoadingLoginContr.value.stop();
              },
            ))
        /* Container(
          margin: EdgeInsets.only(top: 50),
          child: RaisedButton(
            //  color: Get.isDarkMode ? Theme.of(context).accentColor : Colors.teal,
            color: Theme.of(context).primaryColor,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              if (authController.getLoginformKey.currentState.validate()) {
                authController.getLoginformKey.currentState.save();
                authController.login(
                    emailController.text, passwordController.text);
              }
            },
            child: Text(
              "Login",
              style: TextStyle(
                // color: Get.isDarkMode ? Colors.black : Colors.white,
                color: Get.isDarkMode ? null : Colors.white,
                letterSpacing: 1.5,
                // fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
        */
      ],
    );
  }

  /* Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text("Forgot Password"),
        ),
      ],
    );
  }
  */

  Widget _buildEmailRow() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (val) => val.isNullOrBlank ? "Enter Email Please" : null,
      onSaved: (val) => emailController.text = val,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
          ),
          labelText: 'E-mail'),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        validator: (val) => val.isNullOrBlank ? "Enter Password Please" : null,
        onSaved: (val) => passwordController.text = val,
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
          ),
          labelText: 'Password',
        ),
      ),
    );
  }
}
