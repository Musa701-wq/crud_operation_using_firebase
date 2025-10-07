import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart' show UserModel;


class SignupController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("⚠️ Error", "All fields are required");
      return;
    }

    try {
      isLoading.value = true;

      // Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      String uid = userCredential.user!.uid;

      // User model create
      UserModel user = UserModel(
        uid: uid,
        name: name.trim(),
        email: email.trim(),
      );

      // Firestore me store karna
      await _firestore.collection("users").doc(uid).set(user.toMap());

      Get.snackbar("✅ Success", "Account created successfully");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("⚠️ Error", e.message ?? "Something went wrong");
    } catch (e) {
      Get.snackbar("⚠️ Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
