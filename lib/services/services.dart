import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter/material.dart';

class services{
  static Future<void> createUser(BuildContext context,String name, int age) async {
    try {
      await FirebaseFirestore.instance.collection("users").add({
        "name": name,
        "age": age,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ User Added")),
      );
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  // Update
  static Future<void> updateUser(BuildContext context,String docId, String newName, int newAge) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(docId)
          .update({"name": newName, "age": newAge});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ User Updated")),
      );
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  // Delete
  static Future<void> deleteUser(BuildContext context,String docId) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🗑 User Deleted")),
      );
    } catch (e) {
      print("❌ Error: $e");
    }
  }

}