import 'package:expense_manager/db_services/database.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:get/get.dart';

class SelectUsrController extends GetxController {
  var allUserList = List<Usr>().obs;
  var res = 'not found'.obs;

  @override
  void onInit() {
    allUserList.bindStream(Database().getAllUsers());
  }

  // Future showUsr(BuildContext context, String name) async {
  //   var allUsers = await FirebaseFirestore.instance
  //       .collection("users")
  //       .where('name', isGreaterThanOrEqualTo: name)
  //       .get();
  // }
}
