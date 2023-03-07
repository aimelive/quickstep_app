import 'package:get/get.dart';

class AuthState extends GetxController {
  RxBool isSignedIn = RxBool(false);
  RxString email = RxString("");
  RxString token = RxString("");
}
