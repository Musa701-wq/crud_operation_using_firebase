import 'package:crrud_operations/View/add_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../main_screen.dart';

class login_controller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    print("⚠️ Error: Email or Password field is empt");

    if (email.isEmpty || password.isEmpty) {
      print("⚠️ Error: Email or Password field is empty");
      Get.snackbar("⚠️ Error", "All fields are required");
      return;
    }


    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // ✅ Console me status print
      print("✅ Login Successful");
      print("User UID: ${userCred.user?.uid}");
      print("User Email: ${userCred.user?.email}");

      Get.snackbar(
        "Success",
        "Login Successful!",
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAll(() => MainScreen());

    } catch (e) {
      print("❌ Login Failed: $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
