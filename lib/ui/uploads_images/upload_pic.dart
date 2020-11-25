import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/uploadImages/upload_images_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadPictures extends GetWidget<UploadImagesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: Scaffold(
        //

        appBar: AppBar(
          title: Text('Multiple Images'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.image),
                text: 'Images',
              ),
              Tab(
                icon: Icon(Icons.cloud_upload),
                text: "Upload Images",
              ),
            ],
            indicatorColor: Colors.red,
            indicatorWeight: 5.0,
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            Center(
              child: Container(
                child: Text('uppppppppp'),
              ),
            ),
            upload(context),
          ],
        ),
      ),
    ));
  }

  Widget upload(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      controller.loadAssets();
                    },
                    child: Container(
                      width: 130,
                      height: 50,
                      child: Center(
                          child: Text(
                        "Pick images",
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.images.length == 0) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                // backgroundColor:
                                //     Theme.of(context).backgroundColor,
                                content: Text(
                                  "No image selected",
                                ),
                                actions: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 30,
                                      // backgroundColor:
                                      //     MultiPickerApp.navigateButton,
                                      // backgroundDarkerColor:
                                      //     MultiPickerApp.background,
                                      child: Center(
                                          child: Text(
                                        "Ok",
                                      )),
                                    ),
                                  )
                                ],
                              );
                            });
                      } else {
                        controller.uploadImages();
                      }
                    },
                    child: Container(
                      width: 130,
                      height: 50,
                      child: Center(
                          child: Text(
                        "Upload Images",
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: buildGridView(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGridView() {
    return Obx(
      () => GridView.count(
        crossAxisCount: 3,
        children: List.generate(controller.images.length, (index) {
          Asset asset = controller.images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      ),
    );
  }
}
