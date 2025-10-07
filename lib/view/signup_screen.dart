import 'package:crrud_operations/widgets/custom_button.dart';
import 'package:crrud_operations/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../controllers/signup_controller.dart';
import '../controllers/user_controller.dart' show UserController;
import 'login_screen.dart' show login_screen;

class signup_screen extends StatelessWidget {
  signup_screen({super.key});
  final SignupController controller = Get.put(SignupController());
  final TextEditingController email_controller=TextEditingController();
  final TextEditingController pass_controller=TextEditingController();
  final TextEditingController name_controller=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,

          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Create New Account",
                style: TextStyle(
                    color: Colors.white,fontSize: 35,
                    fontWeight: FontWeight.bold
                ),)),
              SizedBox(
                height: 50,
              ),
              CustomTextField(controller:name_controller , label: "Name", hint: "Enter Full Name", icon: Icons.email),
              SizedBox(
                height: 22,
              ),
              CustomTextField(controller:email_controller , label: "Email", hint: "Enter email", icon: Icons.email),
              SizedBox(
                height: 19,
              ),
              CustomTextField(controller:pass_controller , label: "Password", hint: "Enter Password", icon: Icons.password),
              SizedBox(
                height: 120,
              ),
              CustomButton(label: "Signup", icon: Icons.add, onPressed: (){
                controller.signup(
                  name: name_controller.text
                , email:  email_controller.text,
                  password: pass_controller.text,
                );

              },


              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));

                  }, child: Text("Already have an account >",
                style: TextStyle(
                  color: Colors.white,fontSize: 15,
                  // fontWeight: FontWeight.bold
                ),))

            ],
          ),
        ),

      ),
    );
  }
}
