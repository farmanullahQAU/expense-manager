import 'package:expense_manager/controllers/bindings/home_binding.dart';
import 'package:expense_manager/ui/Chat/send_message.dart';
import 'package:expense_manager/ui/Labor/add_labor.dart';
import 'package:expense_manager/ui/Reports/payment_report.dart';
import 'package:expense_manager/ui/Reports/project_report.dart';
import 'package:expense_manager/ui/add_customer.dart';
import 'package:expense_manager/ui/admin_ui/login1.dart';
import 'package:expense_manager/ui/pm_uis/addPayment/add_payment.dart';

import 'package:expense_manager/ui/pm_uis/add_project.dart';
import 'package:expense_manager/ui/pm_uis/bankAccounts/add_account.dart';
import 'package:expense_manager/ui/pm_uis/pm_home.dart';

import 'package:expense_manager/ui/uploads_images/upload_pic.dart';
import 'package:expense_manager/utils/root.dart';
import 'package:expense_manager/ui/Reports/pdf_viewer.dart';
import 'package:expense_manager/ui/Reports/labor_report.dart';
import 'package:expense_manager/ui/admin_ui/project_contracts.dart';
import 'package:expense_manager/ui/FetchProject.dart';
import 'package:expense_manager/ui/uploads_images/fetch_images.dart';
import 'package:expense_manager/ui/Materials/addMaterail.dart';

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
      name: '/paymentReportUi',
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
      name: '/fetchImagesUi',
      page: () => FetchImages(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/sendMessageUi',
      page: () => SendMessage(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/projectReportUi',
      page: () => ProjectReprot(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/addLaborUi',
      page: () => AddLabor(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/pdfViewerUi',
      page: () => PdfViewer(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/laborReportUi',
      page: () => LabotReport(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/projectContractUi',
      page: () => ProjectContractsUi(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: '/fetchProjectsUi',
      page: () => FetchProject(),
    ),
      GetPage(
      binding: HomeBinding(),
      name: '/addMaterialUi',
      page: () => AddMaterial(),
    ),
    
    
    
  ];
}
