import 'package:expense_manager/controllers/Admin/addLaborCategorController.dart';
import 'package:expense_manager/controllers/BankAccountController/add_bank_acc_controller.dart';
import 'package:expense_manager/controllers/ChatController/send_message_controller.dart';
import 'package:expense_manager/controllers/ReportsController/payment_report_controller.dart';
import 'package:expense_manager/controllers/ReportsController/project_report_controller.dart';
import 'package:expense_manager/controllers/authController/auth_controller.dart';
import 'package:expense_manager/controllers/paymentController/add_paymentController.dart';
import 'package:expense_manager/controllers/profileController/profile_controller.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:expense_manager/controllers/uploadImages/upload_images_controller.dart';
import 'package:expense_manager/controllers/user_controller.dart';
import 'package:expense_manager/controllers/LaborControllers/add_labor_controller.dart';
import 'package:expense_manager/controllers/ReportsController/labor_report_controller.dart';
import 'package:expense_manager/controllers/ReportsController/pdf_viewer_controller.dart';
import 'package:expense_manager/controllers/Admin/projectContractController.dart';

import 'package:get/instance_manager.dart';
import 'package:expense_manager/controllers/NotificationPlugin/pushNotification.dart';

import 'package:get/get.dart';

import '../add_project_controller/add_project_controller.dart';
import '../errorHandler.dart';
import '../pm_hom_botom_Nav_controller.dart';
import '../pm_home_controller.dart';
import '../FetchProjectContr/Fetch_Project_Controller.dart';
import 'package:expense_manager/controllers/MaterialControllers/AddMaterialController.dart';
import 'package:expense_manager/controllers/AddCustPmController.dart';
import 'package:expense_manager/controllers/invitationController.dart';
import 'package:expense_manager/controllers/Admin/changeLogoController.dart';


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
    Get.lazyPut(() => PaymentReportController());
    Get.lazyPut(() => AddBankAccountController());
    Get.lazyPut(() => UploadImagesController());
    Get.lazyPut(() => ErrorController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => SendMessageController());
    Get.lazyPut(() => ProjectReportController());
    Get.lazyPut(() => SelectProjectController());
    Get.lazyPut(() => AddLaborController());
    Get.lazyPut(() => LaborReportController());
    Get.lazyPut(() => PdfViewrController());
    Get.lazyPut(() => ProjectContractController());
    Get.lazyPut(() => FetchProjectController());
    Get.lazyPut(() => AddLaborCategoryController());
    Get.lazyPut(() => AddMaterialController());
    Get.lazyPut(() => FirebasePushNotificationService());
    Get.lazyPut(() => AddCustomerOrpmController());
    Get.lazyPut(() => InvitationController());
    Get.lazyPut(() => ChangeLogoController());

    

    

    

    

    

    

    /* Get.put<AuthController>(AuthController(), permanent: true);
       when we use this put approach then when we run our program each controller will be initilize
       
       */
  }
}
