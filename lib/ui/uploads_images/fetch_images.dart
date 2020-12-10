import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/uploadImages/upload_images_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/models/image_model.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FetchImages extends GetWidget<UploadImagesController> {
  var slectedProjecCont = Get.find<SelectProjectController>();

  var currUser = Get.put(UsrController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.9,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Projects")
            .doc(slectedProjecCont.currentProject.value.id)
            .collection("Pictures")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            print('images exists');
            return ListView(
              children: snapshot.data.docs.map((e) {
                var images = Images.fromMap(e.data());

                return Column(
                  children: [
                    /*
                     Container(
                      width: context.width * 0.9,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(images.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // title: Text(bank.bankName),
                      // subtitle: Text(bank.branch),
                    ),
                    */

                    Container(
                      width: Get.context.width * 0.9,
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 9.0),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            ListTile(
                              trailing:
                                  Text(DateFormat.jm().format(images.date)),
                              leading: Icon(Icons.arrow_drop_down_circle),
                              title: Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(DateFormat.yMMMd().format(images.date)),
                                ],
                              ),
                              subtitle: Text(
                                currUser.currLoggedInUsr.value.name,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            images.imageUrl != null
                                ? Image.network(
                                    images.imageUrl,
                                    fit: BoxFit.fill,
                                  )
                                : CircularProgressIndicator(
                                    strokeWidth: 4.0,
                                  ),
                          ],
                        ),
                        // semanticContainer: true,
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        // child: Image.network(
                        //   images.imageUrl,
                        //   fit: BoxFit.fill,
                        // ),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                        // elevation: 5,
                        // margin: EdgeInsets.all(10),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }
          return Center(
              child: Container(
                  width: 90, height: 40, child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
