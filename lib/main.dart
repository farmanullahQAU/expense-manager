import 'package:expense_manager/routes/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'controllers/bindings/home_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBinding(),
      /* if we have multiple controller and we want to access 
      access a controller from another page we use Get.put(controller name ) */

      defaultTransition: Transition.zoom,
      title: 'Flutter Demo',
      initialRoute: '/root',
      getPages: RouterClass.route,
    );
  }
}
