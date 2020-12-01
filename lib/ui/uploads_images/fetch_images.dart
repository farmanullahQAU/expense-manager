import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/uploadImages/upload_images_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/models/image_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FetchImages extends GetWidget<UploadImagesController> {
  var currUser = Get.put(UsrController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.9,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("projects")
            .doc(controller.currProject.value.id)
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
                    Divider(
                      color: Theme.of(context).primaryColor,
                      height: 2,
                    ),
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

                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            trailing: Text(DateFormat.jm().format(images.date)),
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
                          Image.network(
                            images.imageUrl,
                            fit: BoxFit.fill,
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
