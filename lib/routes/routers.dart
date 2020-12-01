import 'package:expense_manager/controllers/bindings/home_binding.dart';
import 'package:expense_manager/ui/Chat/send_message.dart';
import 'package:expense_manager/ui/Reports/payment_report.dart';
import 'package:expense_manager/ui/add_customer.dart';
import 'package:expense_manager/ui/admin_ui/login1.dart';
import 'package:expense_manager/ui/pm_uis/addPayment/add_payment.dart';

import 'package:expense_manager/ui/pm_uis/add_project.dart';
import 'package:expense_manager/ui/pm_uis/bankAccounts/add_account.dart';
import 'package:expense_manager/ui/pm_uis/pm_home.dart';
import 'package:expense_manager/ui/uploads_images/upload_pic.dart';
import 'package:expense_manager/utils/root.dart';

import 'package:get/get.dart';

class RouterClass {
  static final route = [
    GetPage(
      name: '/addCustomer',
      page: () => AddCustomer(),
      binding: HomeBinding(),
    ),
    GetPage(name: '/login1View', page: () => Login1(), binding: HomeBinding()),
    GetPage(
        name: '/PmHomeBottomNavView',
        page: () => PmHomeBottomNav(),
        binding: HomeBinding()),
    GetPage(
      binding: HomeBinding(),
      name: '/root',
      page: () => Root(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/addProject',
      page: () => AddProject(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/addPaymentUi',
      page: () => AddPayment(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/PmHomeTabNavView',
      page: () => PmHomeTabNav(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/paymenrReportUi',
      page: () => PaymentReport(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/addBankAccountUi',
      page: () => AddBankAccount(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/uploadPictureUi',
      page: () => UploadPictures(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/sendMessageUi',
      page: () => SendMessage(),
    ),
  ];
}
