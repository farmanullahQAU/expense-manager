import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/controllers/Admin/projectContractController.dart';
import 'package:expense_manager/controllers/FetchProjectContr/Fetch_Project_Controller.dart';

class FetchProject extends GetWidget<FetchProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects')),
      body: Center(
        child: Container(
          color: Get.isDarkMode
              ? Theme.of(context).primaryColor
              : Colors.grey[800],
          child: Obx(() {
            if (controller.userType.value == "Admin")
              return adminProjectsListView();
            else if (controller.userType.value == "Project manager")
              return pmProjectsListView();
            else
              return customerProjectsListView();
          }),
        ),
      ),
    );
  }

  adminAddCategoryDialog(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false, //enable and disable outside click
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: <Widget>[
          Row(
            children: [
              RaisedButton(
                  child: Text('Ok'),
                  color: Theme.of(context).primaryColor,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () async {
                    // if (controller.addContractFormKey.value.currentState
                    //     .validate()) {
                    //   controller.addContractFormKey.value.currentState.save();

                    //   if (controller.isUpdate.value == true) {
                    //     var contract = new ProjectContracts(
                    //         contractName: controller.contractNameString.value,
                    //         contractDesc: controller.contractDesString.value);

                    //     controller.projectContractObj.value = contract;
                    //     await controller.updateContrac();
                    //     controller.reSet();
                    //   } else {
                    //     var newContract = ProjectContracts(
                    //         contractName: controller.contractDesString.value,
                    //         contractDesc: controller.contractDesString.value);
                    //     controller.projectContractObj.value = newContract;
                    //     controller.addNewContract();
                    //   }
                    //   Get.back();
                    //   //  Get.toNamed(routeName); //navigate to upload picuture ui
                    // }
                  }),
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
        title: Obx(() => controller.isUpdate.value == true
            ? Text('Update Contract')
            : Text('Add Contract')),
        content: SingleChildScrollView(
          child: Form(
              //    key: controller.addContractFormKey.value,
              child: Column(
            children: [
              TextFormField(
                //      controller: controller.contractNameEditingController.value,
                validator: (val) =>
                    val.isEmpty ? "Plz enter contract name" : null,
                onSaved: (val) => controller.contractNameString.value = val,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  contentPadding: EdgeInsets.all(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  //  controller: controller.contractDesEditingController.value,
                  validator: (val) =>
                      val.isEmpty ? "Plz enter contract description" : null,
                  onSaved: (val) => controller.contractDesString.value = val,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'description',
                    filled: true,
                    contentPadding: EdgeInsets.all(4),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  // addPhoto(Project projectObj) {
  //   return projectObj.customer.photoUrl != null
  //       ? Material(
  //           child: CachedNetworkImage(
  //             width: 100,
  //             height: 100,
  //             imageUrl: projectObj.customer.photoUrl,
  //             fit: BoxFit.cover,
  //             placeholder: (context, url) => Center(
  //               child: Container(
  //                   width: 100,
  //                   height: 100,
  //                   padding: EdgeInsets.all(10),
  //                   child: CircularProgressIndicator(
  //                     strokeWidth: 2.0,
  //                     valueColor: AlwaysStoppedAnimation(
  //                         Theme.of(context).primaryColor),
  //                   )),
  //             ),
  //           ),
  //           borderRadius: BorderRadius.all(Radius.circular(125.0)),
  //           clipBehavior: Clip.hardEdge,
  //         )
  //       : Icon(
  //           Icons.account_circle,
  //           size: 100,
  //           // color: Colors.grey
  //         );
  // }

  ListView adminProjectsListView() {
    return ListView.builder(
      itemCount: controller.allAdminProjects.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        var project = controller.allPmProjects[i];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date End:'),
                    Text(project.endDate),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date Start:'),
                    Text(project.starDate),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Relation: ',
                    ),
                    Text(project.customerRelation,
                        style: TextStyle(color: Colors.black.withOpacity(0.5))),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Cost:'),
                        Text(project.estimatedCost)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Labor Wages:'),
                        Text(project.totalWageAmount)
                      ],
                    ),
                  ),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {
                      // controller.contractDesEditingController.value.text =
                      //     controller.allProjectContracts[i].contractDesc;

                      // controller
                      //         .contractNameEditingController.value.text =
                      //     controller.allProjectContracts[i].contractDesc;
                      // controller.isUpdate.value = true;
                      // controller.reference.value =
                      //     controller.allProjectContracts[i].reference;
                      adminAddCategoryDialog(context);
                    },
                    child: Icon(Icons.edit),
                  ),
                  FlatButton(
                    onPressed: () {
                      // controller.reference.value =
                      //   controller.allProjectContracts[i].reference;
                      Get.defaultDialog(
                          barrierDismissible: false,
                          title: 'Confirm',
                          middleText: "Are you sure to delete?",
                          cancelTextColor: Get.isDarkMode
                              ? Theme.of(context).primaryColor
                              : Colors.red,
                          onCancel: () {
                            Get.back();
                          },
                          confirmTextColor: Colors.white,
                          textConfirm: 'OK',
                          onConfirm: () {
                            //   controller.deleteContract();
                          });

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
    );
  }

  ListView pmProjectsListView() {
    return ListView.builder(
      itemCount: controller.allPmProjects.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        var project = controller.allPmProjects[i];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date End:'),
                    Text(project.endDate),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date Start:'),
                    Text(project.starDate),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Relation: ',
                    ),
                    Text(project.customerRelation,
                        style: TextStyle(color: Colors.black.withOpacity(0.5))),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Cost:'),
                        Text(project.estimatedCost)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Labor Wages:'),
                        Text(project.totalWageAmount)
                      ],
                    ),
                  ),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {
                      // controller.contractDesEditingController.value.text =
                      //     controller.allProjectContracts[i].contractDesc;

                      // controller
                      //         .contractNameEditingController.value.text =
                      //     controller.allProjectContracts[i].contractDesc;
                      // controller.isUpdate.value = true;
                      // controller.reference.value =
                      //     controller.allProjectContracts[i].reference;
                      adminAddCategoryDialog(context);
                    },
                    child: Icon(Icons.edit),
                  ),
                  FlatButton(
                    onPressed: () {
                      // controller.reference.value =
                      //   controller.allProjectContracts[i].reference;
                      Get.defaultDialog(
                          barrierDismissible: false,
                          title: 'Confirm',
                          middleText: "Are you sure to delete?",
                          cancelTextColor: Get.isDarkMode
                              ? Theme.of(context).primaryColor
                              : Colors.red,
                          onCancel: () {
                            Get.back();
                          },
                          confirmTextColor: Colors.white,
                          textConfirm: 'OK',
                          onConfirm: () {
                            //   controller.deleteContract();
                          });

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
    );
  }

  ListView customerProjectsListView() {
    return ListView.builder(
      itemCount: controller.allCustomesrProject.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        var project = controller.allPmProjects[i];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date End:'),
                    Text(project.endDate),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date Start:'),
                    Text(project.starDate),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Relation: ',
                    ),
                    Text(project.customerRelation,
                        style: TextStyle(color: Colors.black.withOpacity(0.5))),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Cost:'),
                        Text(project.estimatedCost)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Labor Wages:'),
                        Text(project.totalWageAmount)
                      ],
                    ),
                  ),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () {
                      // controller.contractDesEditingController.value.text =
                      //     controller.allProjectContracts[i].contractDesc;

                      // controller
                      //         .contractNameEditingController.value.text =
                      //     controller.allProjectContracts[i].contractDesc;
                      // controller.isUpdate.value = true;
                      // controller.reference.value =
                      //     controller.allProjectContracts[i].reference;
                      adminAddCategoryDialog(context);
                    },
                    child: Icon(Icons.edit),
                  ),
                  FlatButton(
                    onPressed: () {
                      // controller.reference.value =
                      //   controller.allProjectContracts[i].reference;
                      Get.defaultDialog(
                          barrierDismissible: false,
                          title: 'Confirm',
                          middleText: "Are you sure to delete?",
                          cancelTextColor: Get.isDarkMode
                              ? Theme.of(context).primaryColor
                              : Colors.red,
                          onCancel: () {
                            Get.back();
                          },
                          confirmTextColor: Colors.white,
                          textConfirm: 'OK',
                          onConfirm: () {
                            //   controller.deleteContract();
                          });

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
    );
  }
}
