import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../controllers/add_to_do_controller.dart' show to_do_Controller, ToDoController;

class create_todo extends StatelessWidget {
  create_todo({super.key});

  final ToDoController controller = Get.put(ToDoController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create To do", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF283593),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Input Fields
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF283593), Color(0xFF607D8B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    controller: titleController,
                    label: "Title",
                    hint: "Enter title of task",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: desController,
                    label: "Description",
                    hint: "Enter Description of task",
                    icon: Icons.calendar_today,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Create/Update Button
            Obx(() => CustomButton(
              label: controller.editingDocId.value.isEmpty ? "Add task" : "Update task",
              icon: controller.editingDocId.value.isEmpty ? Icons.add : Icons.update,
              onPressed: () {
                if (controller.editingDocId.value.isEmpty) {
                  controller.createTask(titleController.text, desController.text);
                } else {
                  controller.updateTask(titleController.text, desController.text);
                }
                // Clear text fields after operation
                titleController.clear();
                desController.clear();
              },
            )),

            const Divider(thickness: 2, color: Colors.black),
            const SizedBox(height: 5),

            // Users List
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    var task = controller.tasks[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      color: const Color(0xFF607D8B),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF283593),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(task.title,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text( task.description, style: const TextStyle(color: Colors.white)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color(0xFF283593)),
                              onPressed: () {
                                titleController.text = task.title;
                                desController.text = task.description.toString();
                                controller.setEditing(task);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFF283593)),
                              onPressed: () => controller.deleteTask(task.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
