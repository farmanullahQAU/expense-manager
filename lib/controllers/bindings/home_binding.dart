import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/authController/auth_error_handler_controller.dart';
import 'package:expense_manager/controllers/customer_controller/customer_controller.dart';
import 'package:expense_manager/controllers/paymentController/add_paymentController.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/ui/pm_uis/add_project.dart';
import 'package:get/instance_manager.dart';

import 'package:get/get.dart';

import '../add_project_controller/add_project_controller.dart';
import '../pm_hom_botom_Nav_controller.dart';
import '../pm_home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    /* Get.lazyPut(
      () => StudentController(),
    );
    Get.lazyPut(() => AuthController());
    */

    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => AddProjectController());
    Get.lazyPut(() => UsrController());
    Get.lazyPut(() => PmHomeBottomNavController());
    Get.lazyPut(() => PmHomeTabNavController());

    Get.lazyPut(() => AddProjectController());
    Get.lazyPut(() => AddPaymentController());

    /* Get.put<AuthController>(AuthController(), permanent: true);
   when we use this put approach then when we run our program each controller will be initilize
   
   */
  }
}
