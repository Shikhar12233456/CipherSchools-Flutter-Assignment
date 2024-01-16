import 'package:cipherx/back-end/auth-handler.dart';
import 'package:cipherx/consts/consts.dart';
import 'package:cipherx/screens/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool policy = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_rounded)),
        centerTitle: true,
        title: const Text("Sign up"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              customTextField("Name", nameController, size),
              customTextField("Email", emailController, size),
              customPasswordTextField("Password", passwordController, size),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Obx(() => IconButton(
                        onPressed: () {
                          policy.toggle();
                        },
                        icon: Icon(
                          policy.value
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          color: Colors.purple,
                        ))),
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "By Singing up, you agree to the",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          text: "Terms of Service and privacy policy",
                          style: const TextStyle(color: Colors.purple)),
                    ])),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {
                    AuthHandler()
                        .signUpWithEmailPassword(nameController.text,
                            emailController.text, passwordController.text)
                        .whenComplete(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    });
                  },
                  child: Container(
                    // color: Colors.purple,
                    alignment: Alignment.center,
                    height: 50,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  )),
              const Text("or with"),
              TextButton(
                  onPressed: () {
                    AuthHandler().signUpwithGoogle().whenComplete(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("Sign up with Google"),
                  )),
              Container(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "already have an account? ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                          color: primaryColor,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () {})
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      String text, TextEditingController controller, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.9,
        height: 50,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: "Enter $text",
              label: Text(text),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)))),
        ),
      ),
    );
  }

  Widget customPasswordTextField(
      String text, TextEditingController controller, Size size) {
    RxBool show = false.obs;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.9,
        height: 50,
        child: Obx(() => TextField(
              controller: controller,
              obscureText: show.value,
              decoration: InputDecoration(
                  hintText: "Enter $text",
                  label: Text(text),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.5))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.5))),
                  suffix: IconButton(
                      onPressed: () {
                        show.toggle();
                      },
                      icon: Icon(show.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.abc))),
            )),
      ),
    );
  }
}
