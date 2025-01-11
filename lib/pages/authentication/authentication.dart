import 'package:flutter/material.dart';
import 'package:vrsstranslinkcompany/constants/style.dart';
import 'package:vrsstranslinkcompany/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Services/LoginService.dart';
import 'controller/authcontroller.dart';


class AuthenticationPage extends GetView<AuthController> {
   AuthenticationPage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  CustomText(
                    text: "Welcome back to the admin panel.",
                    color: lightGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                controller: controller.passwordController,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
               const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  CustomText(
                    text: "Forgot password?",
                    color: active
                  )
                ],
              ),
                const SizedBox(
                height: 15,
              ),

             Obx(()=>InkWell(
                onTap: (controller.email.isEmpty  || controller.password.isEmpty
                )?null:(){
                  controller.checkLogin(
                    controller.emailController.text,
                    controller.passwordController.text,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:  (controller.email.isEmpty  || controller.password.isEmpty)
                          ? lightGrey
                          : active,
                  borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "Login as Company",
                    color: Colors.white,
                  ),
                ),
              ),
             ),
              const SizedBox(
                height: 15,
              ),
              RichText(text: const TextSpan(
                children: [
                  TextSpan(text: "Do not have admin credentials? "),
                  TextSpan(text: "Request Credentials! ", style: TextStyle(color: active))
                ]
              ))

            ],
          ),
        ),
      ),
    );
  }
}
