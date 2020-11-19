import 'package:expense_manager/ui/admin_ui/login1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addPayment/add_payment.dart';

class AddNew extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        // color: Get.isDarkMode ? Colors.grey[700] : Colors.greenAccent,
        child: GridView.count(
          crossAxisCount: context.isLandscape ? 3 : 2,
          children: [
            InkWell(
              child: addCard(context, Colors.green, 'Add Payment',
                  Icons.store_mall_directory),
              onTap: () {
                // Get.defaultDialog(
                //   barrierDismissible: true,
                //   onCancel: () {},
                //   confirmTextColor: Get.isDarkMode
                //       ? Theme.of(context).primaryColor
                //       : Colors.white,

                //   onConfirm: () {},
                //   title: 'Add Payment',
                //   //payment option ui displa
                //   actions: [
                //     AddPayment(),
                //   ],
                //   radius: 10.0,
                // );
                Get.toNamed('addPaymentUi');
              },
            ),
            InkWell(
              child: addCard(context, Colors.red, ' Add Labor',
                  Icons.account_balance_wallet),
              onTap: () {
                //  Get.to(Login1());
              },
            ),
            addCard(context, Colors.purple, 'Add Contracts', Icons.work),
            addCard(
                context, Colors.deepOrangeAccent, 'Add other', Icons.subway),
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
