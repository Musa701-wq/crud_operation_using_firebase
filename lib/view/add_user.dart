import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';

class FirstPage extends StatelessWidget {
  FirstPage({super.key});

  final UserController controller = Get.put(UserController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

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
                    controller: nameController,
                    label: "Name",
                    hint: "Enter your name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: ageController,
                    label: "Age",
                    hint: "Enter your age",
                    icon: Icons.calendar_today,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Create/Update Button
            Obx(() => CustomButton(
              label: controller.editingDocId.value.isEmpty ? "Create User" : "Update User",
              icon: controller.editingDocId.value.isEmpty ? Icons.add : Icons.update,
              onPressed: () {
                if (controller.editingDocId.value.isEmpty) {
                  controller.createUser(nameController.text, ageController.text);
                } else {
                  controller.updateUser(nameController.text, ageController.text);
                }
                // Clear text fields after operation
                nameController.clear();
                ageController.clear();
              },
            )),

            const Divider(thickness: 2, color: Colors.black),
            const SizedBox(height: 5),

            // Users List
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    var user = controller.users[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      color: const Color(0xFF607D8B),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF283593),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text("${user['name']} (Age: ${user['age']})",
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(user['id'], style: const TextStyle(color: Colors.white)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color(0xFF283593)),
                              onPressed: () {
                                nameController.text = user['name'];
                                ageController.text = user['age'].toString();
                                controller.setEditing(user);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFF283593)),
                              onPressed: () => controller.deleteUser(user['id']),
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
