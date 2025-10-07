import 'package:crrud_operations/view/signup_screen.dart';
import 'package:crrud_operations/widgets/custom_button.dart';
import 'package:crrud_operations/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../controllers/login_controller.dart';

class login_screen extends StatelessWidget {
   login_screen({super.key});
   final login_controller controller = Get.put(login_controller());
  final TextEditingController email_controller=TextEditingController();
  final TextEditingController pass_controller=TextEditingController();



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
                Center(child: Text("Login",
                  style: TextStyle(
                      color: Colors.white,fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),)),
                SizedBox(
                  height: 50,
                ),
                CustomTextField(controller:email_controller , label: "Email", hint: "Enter Your email", icon: Icons.email),
               SizedBox(
                 height: 19,
               ),
                CustomTextField(controller:pass_controller , label: "Password", hint: "Enter Your Password", icon: Icons.password),
                SizedBox(
                  height: 120,
                ),
                CustomButton(label: "Login",
                    icon: Icons.login,
                  onPressed: () {

                      controller.login(
                        email_controller.text.trim(),
                        pass_controller.text.trim(),
                      );

                  }


                ),
                TextButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=>signup_screen()));

                }, child: Text("create new account >",
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
