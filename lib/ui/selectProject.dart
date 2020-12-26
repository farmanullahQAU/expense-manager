import 'package:expense_manager/controllers/select_project_controller.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SelectProject extends GetWidget<SelectProjectController>{
  @override
  Widget build(BuildContext context) {
    return Center();
  }




   showPmSelectProjectDialog(BuildContext context, String routeName) {
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
                  if (controller
                      .selectProjectFormKey.value.currentState
                      .validate()) {
                    controller
                        .selectProjectFormKey.value.currentState
                        .save();
                    Get.back();
if(routeName!="")
{
                   Get.toNamed(routeName);

}
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
        title: Text('Projects Pannel'),
        content: SingleChildScrollView(
          child: Form(
              key: controller.selectProjectFormKey.value,
              child: Column(
                children: [
                  Obx(() {
                    if (controller.projectListPm != null) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          validator: (val) =>
                              val == null ? "Please select project" : null,
                          isDense: true,
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
                          hint: Text('Select Project'),
                          items: controller.projectListPm
                              .map((projectObj) => DropdownMenuItem<Project>(
                                  value: projectObj,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: Text(
                                            projectObj.id.substring(0, 4),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (project) {
                            controller.currentProject.value =
                                project;
                          });
                    }
                    return Text('loading...');
                  }),
                ],
              )),
        ),
      ),
    );
  }
   showAdminSelectProjectDialog(BuildContext context, String routeName) {


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
                  if (controller
                      .selectProjectFormKey.value.currentState
                      .validate()) {
                    controller
                        .selectProjectFormKey.value.currentState
                        .save();
                    Get.back();
if(routeName!="")
{
                   Get.toNamed(routeName);

}
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
        title: Text('Projects Pannel'),
        content: SingleChildScrollView(
          child: Form(
              key: controller.selectProjectFormKey.value,
              child: Column(
                children: [
                  Obx(() {
                    if (controller.projectListAdmin != null) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          validator: (val) =>
                              val == null ? "Please select project" : null,
                          isDense: true,
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
                          hint: Text('Select Project'),
                          items: controller.projectListAdmin
                              .map((projectObj) => DropdownMenuItem<Project>(
                                  value: projectObj,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: Text(
                                            projectObj.id.substring(0, 4),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (project) {
                            controller.currentProject.value =
                                project;
                          });
                    }
                    return Text('loading...');
                  }),
                ],
              )),
        ),
      ),
    );
  }



   showCustomerSelectProjectDialog(BuildContext context, String routeName) {


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
                  if (controller
                      .selectProjectFormKey.value.currentState
                      .validate()) {
                    controller
                        .selectProjectFormKey.value.currentState
                        .save();
                    Get.back();
if(routeName!="")
{
                   Get.toNamed(routeName);

}
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
        title: Text('Projects Pannel'),
        content: SingleChildScrollView(
          child: Form(
              key: controller.selectProjectFormKey.value,
              child: Column(
                children: [
                  Obx(() {
                    if (controller.projectListCustomer != null) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          validator: (val) =>
                              val == null ? "Please select project" : null,
                          isDense: true,
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
                          hint: Text('Select Project'),
                          items: controller.projectListCustomer
                              .map((projectObj) => DropdownMenuItem<Project>(
                                  value: projectObj,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: Text(
                                            projectObj.id.substring(0, 4),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (project) {
                            controller.currentProject.value =
                                project;
                          });
                    }
                    return Text('loading...');
                  }),
                ],
              )),
        ),
      ),
    );
  }

  
}