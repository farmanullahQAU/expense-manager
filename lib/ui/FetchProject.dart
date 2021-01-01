import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/controllers/Admin/projectContractController.dart';
import 'package:expense_manager/controllers/FetchProjectContr/Fetch_Project_Controller.dart';
import 'package:expense_manager/models/project_contract_model.dart';

class FetchProject extends GetWidget<FetchProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects')),
      body: Center(
        child: Container(
          color: Get.isDarkMode
              ? Theme.of(context).primaryColor
              : Colors.grey[900],
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

  changeContractDialogue(BuildContext context) {
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
                  onPressed: () {
                     if (controller.updateContractFormKey.value.currentState
                        .validate()) {
                      controller.updateContractFormKey.value.currentState.save();

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

                    controller.udateContract();
                    Get.back();
                  }
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
        title: Text('Update Contract'),
          
        content: SingleChildScrollView(
          child: Form(
                 key: controller.updateContractFormKey.value,
              child: Column(
            children: [
             DropdownButtonFormField(
               onSaved: (val)=>controller.currContract.value=val,
                          isExpanded: true,
                          validator: (val) => val == null
                              ? "Select contract "
                              : null,
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
                          hint: Text('Select Contract'),
                          items: controller.allContracts
                              .map((projContractObj) => DropdownMenuItem<ProjectContracts>(
                                  value: projContractObj,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: new Text(
                                            projContractObj.contractName,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )))
                              .toList(),
                          onChanged: (project) {
                            controller.currContract.value =
                                project;
                          },
             )
              
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
        var project = controller.allAdminProjects[i];
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
                        Text(project.totalWageAmount.toString())
                      ],
                    ),
                  ),
                ],
              ),

                  Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal:16.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text('Contract'),
                    Text(project.projectContract.contractName),
                  ],
                ),
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
                        Text(project.totalWageAmount.toString())
                      ],
                    ),
                  ),

                    Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Contracts:'),
                        Text(project.totalContractAmount.toString())
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text('Contract'),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        Text(project.projectContract.contractName),
                        FlatButton(
                          onPressed: () {
                            //select taped project reference
                            controller.projectReference.value =project.reference;
      
                            changeContractDialogue(context);
                          },
                          child: Icon(Icons.edit),
                        ),
             
                      ],
                    ),
                  ],
                ),
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
        var project = controller.allCustomesrProject[i];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                        Text(project.totalWageAmount.toString())
                      ],
                    ),
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
