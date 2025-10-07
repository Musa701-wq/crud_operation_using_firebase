import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class ProfileController extends GetxController {
  var userModel = Rxn<UserModel>(); // reactive user model
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot snapshot =
      await _firestore.collection("users").doc(uid).get();

      if (snapshot.exists) {
        userModel.value =
            UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
