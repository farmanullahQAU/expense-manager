import 'package:get/get.dart';

class PaymentTabController extends GetxController {
  RxString title = 'First'.obs;
  set setTitle(val) {
    this.title.value = val;
  }

  String get getTitle => title.value;
}
