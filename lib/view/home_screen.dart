import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_to_do_controller.dart' show ToDoController;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ToDoController controller = Get.put(ToDoController());
  bool isSwitched=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF283593),
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
            Container(
              width: double.infinity,
              height: 100,
              alignment: Alignment.center,
              child: const Text(
                "Welcome back",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      "No tasks available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.tasks[index]; // use here
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      color: const Color(0xFF607D8B),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Color(0xFF283593),
                                        child: Icon(Icons.task, color: Colors.white),
                                      ),
                                      // Switch(value: isSwitched,
                                      //     onChanged:(value) {
                                      //       setState(() {
                                      //         isSwitched = value;
                                      //       });
                                      //     },)
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    task.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: Text(
                                      task.description,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Color(0xFF283593)),
                                  onPressed: () => controller.deleteTask(task.id),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            )

          ],
        ),
      ),
    );
  }
}
