import 'package:expense_manager/controllers/errorHandler.dart';
import 'package:expense_manager/controllers/uploadImages/upload_images_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'fetch_images.dart';

class UploadPictures extends GetWidget<UploadImagesController> {
  var errorController = Get.put(ErrorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
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
            FetchImages(),
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
              // SizedBox(
              //   height: 20,
              // ),
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
                        controller.uploadImages(context);
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          height: 50,
                          child: Center(
                              child: Text(
                            "Upload Images",
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: buildGridView(context),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGridView(context) {
    return Obx(
      () => GridView.count(
        crossAxisCount: 3,
        children: List.generate(controller.images.length, (index) {
          Asset asset = controller.images[index];

          return Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                AssetThumb(
                  spinner: Center(child: CircularProgressIndicator()),
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  errorDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            // backgroundColor:
            //     Theme.of(context).backgroundColor,
            content: Text(errorController.errorString.value),
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
  }
}
