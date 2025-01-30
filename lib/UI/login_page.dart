import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:word_nest/UI/utils/api/models/login_model.dart';
import 'package:word_nest/UI/utils/api/models/random_word_model.dart';
import 'package:word_nest/UI/utils/api/routa.dart';
import 'package:word_nest/UI/utils/api/services/http.dart';
import 'package:word_nest/UI/utils/validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static late PageController pageController;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    listeners();
  }

  listeners() {
    tfFocusNode.addListener(() {
      if (tfFocusNode.hasFocus) {
        setState(() {
          isFocused1 = true;
        });
      } else {
        setState(() {
          isFocused1 = false;
        });
      }
    });
    tfFocusNode2.addListener(() {
      if (tfFocusNode2.hasFocus) {
        setState(() {
          isFocused2 = true;
        });
      } else {
        setState(() {
          isFocused2 = false;
        });
      }
    });
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
        setState(() {
          visibilityOfVisibileIcon = true;
        });
      } else {
        setState(() {
          visibilityOfVisibileIcon = false;
        });
      }
    });
  }

  Future<void> login() async {
    setState(() {
      responseLoading = true;
    });
    await HttpBase.post(
            Routa.loginUrl,
            LoginModel(
                    email: emailController.text,
                    password: passwordController.text)
                .toJson())
        .then((response) {
      if (response.statusCode == 200) {
        print("login successfuly");
        setState(() {
          responseLoading = false;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                jsonDecode(response.body)['message'],
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color.fromARGB(255, 36, 72, 101),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
            ),
          );
        }
        setState(() {
          responseLoading = false;
        });
      }
      emailController.clear();
      passwordController.clear();
    });
  }

  FocusNode tfFocusNode = FocusNode();
  FocusNode tfFocusNode2 = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isFocused1 = false;
  bool isFocused2 = false;

  bool obscureText = true;

  bool visibilityOfVisibileIcon = false;

  late LoginModel loginModel;

  bool responseLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              const SizedBox(
                  width: 508 * 0.3,
                  height: 417 * 0.3,
                  child: Image(image: AssetImage('lib/assets/logo.png'))),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 15, right: 15),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: !isFocused1
                        ? null
                        : const LinearGradient(colors: [
                            Color.fromARGB(255, 122, 199, 245),
                            Color.fromARGB(255, 54, 92, 242)
                          ]),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: TextFormField(
                    validator: emailValidator,
                    controller: emailController,
                    focusNode: tfFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 213, 232, 251),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        borderSide: !isFocused1
                            ? const BorderSide(color: Colors.grey, width: 1)
                            : BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                        //borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      hintText: 'E-mail',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: !isFocused2
                        ? null
                        : const LinearGradient(colors: [
                            Color.fromARGB(255, 122, 199, 245),
                            Color.fromARGB(255, 54, 92, 242)
                          ]),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: obscureText,
                    focusNode: tfFocusNode2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Visibility(
                          visible: visibilityOfVisibileIcon,
                          child: Icon(!obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 213, 232, 251),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          borderSide: !isFocused2
                              ? const BorderSide(color: Colors.grey, width: 1)
                              : BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 54,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 122, 199, 245),
                      Color.fromARGB(255, 50, 199, 245),
                      Color.fromARGB(255, 122, 199, 245)
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      tfFocusNode.unfocus();
                      tfFocusNode2.unfocus();
                      if (passwordController.text.isNotEmpty &&
                          emailController.text.isNotEmpty) {
                        await login();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("please enter all fields"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor:
                                const Color.fromARGB(255, 36, 72, 101),
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't you have an account?"),
                  TextButton(
                    onPressed: () {
                      LoginPage.pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom > 0
                    ? MediaQuery.of(context).viewInsets.bottom +
                        MediaQuery.of(context).size.height * 0.01
                    : 0,
              )
            ],
          ),
        ),
        responseLoading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                    child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                )))
            : Container(),
      ],
    );
  }
}
