import 'package:get/get.dart';

class ErrorController extends GetxController {
  var errorString = RxString();
  String handleStorageError(dynamic error) {
    switch (error) {
      case "permission-denied":
        return " You don't have permission to upload picture";

      case "canceled":
        return "The task has been canceled";

      case "ERROR_UNKNOWN":
        return "An unknown error occurred.";

      case "ERROR_OBJECT_NOT_FOUND":
        return "No object exists at the desired reference ";

      case "ERROR_QUOTA_EXCEEDED":
        return "Storage quota has been exceeded, plz upgrade ";

      case "ERROR_NOT_AUTHENTICATED":
        return "please login again and try again.";

      case "ERROR_RETRY_LIMIT_EXCEEDED":
        return "Time out plz Try again.";

      case "ERROR_CANCELED":
        return "You canceled the operation.";
        break;
      default:
        return "An undefined Error happened.";
    }
  }
}
