import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class profile_screen extends StatelessWidget {
  const profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF283593),
              Color(0xFF607D8B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

        ),
        child: Obx(() {
          if (controller.userModel.value == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          final user = controller.userModel.value!;

          return Column(
            children: [
              // 🔹 First 30% container
              Container(
                height: screenHeight * 0.3,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets/images/back.jpg") ,
                          ),
                          const SizedBox(width: 15),
                          Row(
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    user.email,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          ,
                          const SizedBox(width: 35),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward),)
                        ],
                      ),


                    ],
                  ),
                ),
              ),

              // 🔹 Remaining part
              Expanded(
                child: Center(
                  child: Text(
                    "Remaining 70% Area",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
