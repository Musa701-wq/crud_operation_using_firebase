import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var users = <Map<String, dynamic>>[].obs;
  var editingDocId = ''.obs;

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");

  @override
  void onInit() {
    super.onInit();
    // Listen to Firestore changes
    userCollection.snapshots().listen((snapshot) {
      users.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data["id"] = doc.id;
        return data;
      }).toList();
    });
  }

  // Create user
  void createUser(String name, String age) {
    if (name.trim().isEmpty || age.trim().isEmpty) {
      Get.snackbar(
        "⚠️ Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    if (int.tryParse(age.trim()) == null || int.parse(age.trim()) < 0) {
      Get.snackbar(
        "⚠️ Error",
        "Age must be a positive number",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    userCollection.add({
      "name": name.trim(),
      "age": int.parse(age.trim()),
    });
  }

  // Update user
  void updateUser(String name, String age) async {
    if (editingDocId.value.isEmpty) return;
    await userCollection.doc(editingDocId.value).update({
      "name": name.trim(),
      "age": int.parse(age.trim()),
    });
    editingDocId.value = '';
  }

  void deleteUser(String id) async {
    await userCollection.doc(id).delete();
  }

  void setEditing(Map<String, dynamic> user) {
    editingDocId.value = user['id'];
  }
}
