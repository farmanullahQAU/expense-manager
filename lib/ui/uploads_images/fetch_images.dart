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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(title: Text('Pictures'),),
          body: Obx(
          () => Center(
            child: Container(
              color: Get.isDarkMode?Theme.of(context).primaryColor:Colors.grey[900],
              width: context.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Projects")
                    .doc(slectedProjecCont.currentProject.value.id)
                    .collection("Pictures")
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data.docs.map((e) {
                        var images = Images.fromMap(e.data());

                        return Column(
                          children: [
                      

                            Container(
                              width: Get.context.width * 0.9,
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 9.0),
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
                                          Text(
                                              DateFormat.yMMMd().format(images.date)),
                                        ],
                                      ),
                                      subtitle: Text(
                                        images.uploadedBy,
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                    //  images.imageUrl != null
                                    //       ?
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        //border: Border.all(),
                                      //  borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: images.imageUrl != null
                                          ? Image.network(
                                              images.imageUrl,
                                              loadingBuilder: (BuildContext context,
                                                  Widget child,
                                                  ImageChunkEvent loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes
                                                        : null,
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                    ),
                                  ],

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
                            )
                          ],
                        );
                      }).toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
