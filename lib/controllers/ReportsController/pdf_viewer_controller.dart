import 'package:get/get.dart';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/controllers/errorHandler.dart';
import 'package:expense_manager/controllers/select_project_controller.dart';

import 'package:expense_manager/db_services/database.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class PdfViewrController extends GetxController {
  var isLoading = true.obs;
  var document = PDFDocument().obs; //to view pdf
  var appBarTitle = RxString();
}
