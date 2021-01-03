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
        child: Scaffold(
          //

          appBar: AppBar(
            
            title: Text(' Images'),
          actions: [Obx(()=>controller.images.length!=0?
                       IconButton(icon: Icon(Icons.cloud_upload),onPressed: (){
                         controller.uploadImages(context);
         
            
              
            },):Container(width: 0.0,height: 0.0,),
          )],
          ),

          body:Stack(children: [Container(child: buildGridView(context),)],),
          floatingActionButton: FloatingActionButton(

onPressed: (){
                      controller.loadAssets();


  
},
            child: Icon(Icons.add_a_photo),
          ),
        ));
  }

  

  Widget buildGridView(context) {
    return Obx(
      () => GridView.count(
        padding: EdgeInsets.only(top:20),
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

 
}
