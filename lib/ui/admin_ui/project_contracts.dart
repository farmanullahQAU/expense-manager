import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/controllers/Admin/projectContractController.dart';

class ProjectContracts extends GetWidget<ProjectContractController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project Contracts')),
      body: Center(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.allProjectContracts.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, i) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      trailing: Text('CONTRACT'),
                      title:
                          Text(controller.allProjectContracts[i].contractName),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DESCRIPTION'),
                          Text(
                            controller.allProjectContracts[i].contractDesc,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          onPressed: () {
                            // Perform some action
                          },
                          child: Icon(Icons.edit),
                        ),
                        FlatButton(
                          onPressed: () {
                            // Perform some action
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {



        },
      ),
    );
  }

   adminAddCategoryDialog(BuildContext context, String routeName) {
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
                  if (selectProjectController
                      .selectProjectFormKey.value.currentState
                      .validate()) {
                    selectProjectController
                        .selectProjectFormKey.value.currentState
                        .save();
                    Get.back();
                    Get.toNamed(routeName); //navigate to upload picuture ui
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
              key: selectProjectController.selectProjectFormKey.value,
              child: Column(
                children: [
                  Obx(() {
                    if (selectProjectController.projectList != null) {
                      return TextFormField(

                          );
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
