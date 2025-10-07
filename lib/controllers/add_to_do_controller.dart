import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Task_Model.dart';

class ToDoController extends GetxController {
  var tasks = <TaskModel>[].obs;
  //bool isSwitched=false.obs as bool;
  var editingDocId = ''.obs;
  TaskModel newTask = TaskModel(
    id: '',
    title: "",
    description: "",
    uid: "",
  );


  final CollectionReference taskCollection =
  FirebaseFirestore.instance.collection("tasks");
  void fetchTasks(){
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Listen to tasks of logged-in user only, ordered by createdAt
      taskCollection
          .where("uid", isEqualTo: currentUser.uid)
          .orderBy("createdAt", descending: true)
          .snapshots()
          .listen((snapshot) {
        tasks.value = snapshot.docs.map((doc) {
          return TaskModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    }
  }
  @override
  void onInit() {
    super.onInit();

    fetchTasks();



  }

  // Create Task
  void createTask(String title, String description) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (title.trim().isEmpty || description.trim().isEmpty) {
      Get.snackbar(
        "⚠️ Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    TaskModel newtask=TaskModel(

        uid: currentUser?.uid ?? '',
        title:title.trim(),
        description: description.trim(),
        created: FieldValue.serverTimestamp(),
         id: '',
    );

    taskCollection.add({
      newTask.title: title.trim(),
      newTask.description: description.trim(),
      newTask.uid: currentUser?.uid,
      "createdAt": FieldValue.serverTimestamp(),
    }).then((_) {
      fetchTasks();
    });

  }

  // Update Task
  void updateTask(String title, String description) async {
    if (editingDocId.value.isEmpty) return;

    await taskCollection.doc(editingDocId.value).update({
      "title": title.trim(),
      "description": description.trim(),
    }).then((_) {
      fetchTasks();
    });;

    editingDocId.value = '';
  }

  // Delete Task
  void deleteTask(String id) async {
    await taskCollection.doc(id).delete().then((_) {
      fetchTasks();
    });;
  }

  // Set Task for Editing
  void setEditing(TaskModel task) {
    editingDocId.value = task.id;
  }
}
