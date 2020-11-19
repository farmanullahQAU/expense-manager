import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

String handleError(dynamic error) {
  switch (error.code) {
    case "wrong-password":
      return "The password is invalid";

    case "permission-denied":
      return "The caller does not have permission to execute the specified operation";

    case "ERROR_INVALID_EMAIL":
      return "Your email address appears to be malformed.";

    case "network-request-failed":
      return "no network found ";

    case "email-already-in-use":
      return "email in use";

    case "ERROR_WRONG_PASSWORD":
      return "Your password is wrong.";

    case "user-not-found":
      return "User with this email doesn't exist.";

    case "ERROR_USER_DISABLED":
      return "User with this email has been disabled.";

    case "too-many-requests":
      return "Too many unsuccessful login attempts. Please try again later.";

    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Signing in with Email and Password is not enabled.";
      break;
    default:
      return "An undefined Error happened.";
  }
}
