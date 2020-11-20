import 'package:expense_manager/ui/admin_ui/login1.dart';
import 'package:expense_manager/ui/pm_uis/add_project.dart';
import 'package:expense_manager/ui/sliver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Reports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 3 : 2,
          children: [
            InkWell(
              child: addCard(context, Colors.green, 'Vendor Report',
                  Icons.store_mall_directory),
              onTap: () {
                //  Get.toNamed('signUpView');
              },
            ),
            InkWell(
              child: addCard(context, Colors.red, ' Payent Report ',
                  Icons.account_balance_wallet),
              onTap: () {
                {
                  Get.defaultDialog(
                    barrierDismissible: false,
                    onCancel: () {
                      Get.back();
                    },
                    confirmTextColor: Get.isDarkMode
                        ? Theme.of(context).primaryColor
                        : Colors.white,

                    onConfirm: () {
                      Get.back();
                    },
                    title: 'Add Payment',
                    //payment option ui displa
                    actions: [
                      // Text(e.address),
                    ],
                    radius: 10.0,
                  );
                }
              },
            ),
            addCard(context, Colors.purple, 'Labor Report', Icons.work),
            addCard(context, Colors.deepOrangeAccent, 'Material Report',
                Icons.subway),
            InkWell(
              onTap: () {},
              child: addCard(
                context,
                Colors.amber,
                'Add Report',
                Icons.polymer,
              ),
            ),
          ],
        ));
  }

  addCard(BuildContext context, Color color, String title, IconData icon) {
    return Card(
      borderOnForeground: true,
      semanticContainer: false,
      margin: EdgeInsets.all(1),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Get.isDarkMode ? Theme.of(context).accentColor : color,
            size: context.isLandscape ? 50 : 70,
          ),
          Text(title)
        ],
      )),
    );
  }
}
