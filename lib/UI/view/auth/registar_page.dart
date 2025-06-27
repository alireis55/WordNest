import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:word_nest/UI/view/auth/login_page.dart';
import 'package:word_nest/core/models/request/request_register_model.dart';
import 'package:word_nest/core/services/routes/route.dart';
import 'package:word_nest/core/services/http_service.dart';
import 'package:word_nest/UI/utils/validators/validators.dart';

class RegistarPage extends StatefulWidget {
  const RegistarPage({super.key});

  @override
  State<RegistarPage> createState() => _RegistarPageState();
}

class _RegistarPageState extends State<RegistarPage> {
  FocusNode tfFocusNode1 = FocusNode();
  FocusNode tfFocusNode2 = FocusNode();
  FocusNode tfFocusNode3 = FocusNode();
  FocusNode tfFocusNode4 = FocusNode();

  bool isFocused1 = false;
  bool isFocused2 = false;
  bool isFocused3 = false;
  bool isFocused4 = false;

  TextEditingController tfController1 = TextEditingController();
  TextEditingController tfController2 = TextEditingController();
  TextEditingController tfController3 = TextEditingController();
  TextEditingController tfController4 = TextEditingController();

  bool validIcon1 = false;
  bool validIcon2 = false;
  bool validIcon3 = false;
  bool validIcon4 = false;
  bool validIcon5 = false;
  bool validIcon6 = false;
  bool validIcon7 = false;

  bool obscureText = true;
  bool visibilityOfVisibileIcon1 = false;
  bool visibilityOfVisibileIcon2 = false;

  @override
  void initState() {
    super.initState();
    tfFocusNode1.addListener(() {
      if (tfFocusNode1.hasFocus) {
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
    tfFocusNode3.addListener(() {
      if (tfFocusNode3.hasFocus) {
        setState(() {
          isFocused3 = true;
        });
      } else {
        setState(() {
          isFocused3 = false;
        });
      }
    });
    tfFocusNode4.addListener(() {
      if (tfFocusNode4.hasFocus) {
        setState(() {
          isFocused4 = true;
        });
      } else {
        setState(() {
          isFocused4 = false;
        });
      }
    });
    tfController2.addListener(() {
      if (emailValidator(tfController2.text) == null) {
        setState(() {
          validIcon1 = true;
        });
      } else {
        setState(() {
          validIcon1 = false;
        });
      }
    });
    tfController3.addListener(() {
      if (PasswordValidator.validate6Charecter(tfController3.text) == null) {
        setState(() {
          validIcon2 = true;
        });
      } else {
        setState(() {
          validIcon2 = false;
        });
      }
      if (PasswordValidator.validateSpecialCharecter(tfController3.text) ==
          null) {
        setState(() {
          validIcon3 = true;
        });
      } else {
        setState(() {
          validIcon3 = false;
        });
      }
      if (PasswordValidator.validateUpperCase(tfController3.text) == null) {
        setState(() {
          validIcon4 = true;
        });
      } else {
        setState(() {
          validIcon4 = false;
        });
      }
      if (PasswordValidator.validateLowerCase(tfController3.text) == null) {
        setState(() {
          validIcon5 = true;
        });
      } else {
        setState(() {
          validIcon5 = false;
        });
      }
      if (PasswordValidator.validateNumber(tfController3.text) == null) {
        setState(() {
          validIcon6 = true;
        });
      } else {
        setState(() {
          validIcon6 = false;
        });
      }
    });
    tfController3.addListener(() {
      if (tfController3.text.isNotEmpty) {
        tfController4.addListener(() {
          if (tfController3.text == tfController4.text &&
              tfController4.text.isNotEmpty) {
            setState(() {
              validIcon7 = true;
            });
          } else {
            setState(() {
              validIcon7 = false;
            });
          }
        });
      } else {
        setState(() {
          validIcon7 = false;
        });
      }
    });
    tfController3.addListener(() {
      if (tfController3.text.isNotEmpty) {
        setState(() {
          visibilityOfVisibileIcon1 = true;
        });
      } else {
        setState(() {
          visibilityOfVisibileIcon1 = false;
        });
      }
    });
    tfController4.addListener(() {
      if (tfController4.text.isNotEmpty) {
        setState(() {
          visibilityOfVisibileIcon2 = true;
        });
      } else {
        setState(() {
          visibilityOfVisibileIcon2 = false;
        });
      }
    });
  }

  Future<void> register() async {
    setState(() {
      responseLoading = true;
    });
    await HttpBase.post(
            Routa.registerUrl,
            RegisterModel(
                    username: tfController1.text,
                    email: tfController2.text,
                    password: tfController3.text)
                .toJson())
        .then((response) {
      if (response.statusCode == 201) {
        LoginPage.pageController.animateToPage(0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Registration successful. Please login.'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            backgroundColor: const Color.fromARGB(255, 36, 72, 101),
          ));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonDecode(response.body)['message']),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            backgroundColor: const Color.fromARGB(255, 36, 72, 101),
          ));
        }
      }
    });
    setState(() {
      responseLoading = false;
    });
  }

  bool responseLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: !isFocused1
                        ? null
                        : const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 122, 199, 245),
                              Color.fromARGB(255, 54, 92, 242)
                            ],
                          ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: tfController1,
                    focusNode: tfFocusNode1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 213, 232, 251),
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: isFocused1
                            ? BorderSide.none
                            : const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: !isFocused2
                        ? null
                        : const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 122, 199, 245),
                              Color.fromARGB(255, 54, 92, 242)
                            ],
                          ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: tfController2,
                    focusNode: tfFocusNode2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 213, 232, 251),
                      hintText: 'E-mail',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: isFocused2
                            ? BorderSide.none
                            : const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 15),
                child: Row(
                  children: [
                    Icon(
                      validIcon1 ? Icons.check_circle : Icons.cancel,
                      color: validIcon1 ? Colors.green : Colors.red,
                      size: 15,
                    ),
                    const Text(
                      'Valid email address',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: !isFocused3
                        ? null
                        : const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 122, 199, 245),
                              Color.fromARGB(255, 54, 92, 242)
                            ],
                          ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    obscureText: obscureText,
                    controller: tfController3,
                    focusNode: tfFocusNode3,
                    decoration: InputDecoration(
                      suffixIcon: Visibility(
                        visible: visibilityOfVisibileIcon1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 213, 232, 251),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: isFocused3
                            ? BorderSide.none
                            : const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          validIcon2 ? Icons.check_circle : Icons.cancel,
                          color: validIcon2 ? Colors.green : Colors.red,
                          size: 15,
                        ),
                        const Text(
                          'At least 6 characters',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          validIcon3 ? Icons.check_circle : Icons.cancel,
                          color: validIcon3 ? Colors.green : Colors.red,
                          size: 15,
                        ),
                        const Text(
                          'At least 1 special character',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          validIcon4 ? Icons.check_circle : Icons.cancel,
                          color: validIcon4 ? Colors.green : Colors.red,
                          size: 15,
                        ),
                        const Text(
                          'At least 1 uppercase letter',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          validIcon5 ? Icons.check_circle : Icons.cancel,
                          color: validIcon5 ? Colors.green : Colors.red,
                          size: 15,
                        ),
                        const Text(
                          'At least 1 lowercase letter',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          validIcon6 ? Icons.check_circle : Icons.cancel,
                          color: validIcon6 ? Colors.green : Colors.red,
                          size: 15,
                        ),
                        const Text(
                          'At least 1 number',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          validIcon7 ? Icons.check_circle : Icons.cancel,
                          color: validIcon7 ? Colors.green : Colors.red,
                          size: 15,
                        ),
                        const Text(
                          'Confirm password',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: !isFocused4
                        ? null
                        : const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 122, 199, 245),
                              Color.fromARGB(255, 54, 92, 242)
                            ],
                          ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    obscureText: obscureText,
                    controller: tfController4,
                    focusNode: tfFocusNode4,
                    decoration: InputDecoration(
                      suffixIcon: Visibility(
                        visible: visibilityOfVisibileIcon2,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 213, 232, 251),
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: isFocused4
                            ? BorderSide.none
                            : const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 54,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 122, 199, 245),
                        Color.fromARGB(255, 50, 199, 245),
                        Color.fromARGB(255, 122, 199, 245)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (validIcon1 &&
                          validIcon2 &&
                          validIcon3 &&
                          validIcon4 &&
                          validIcon5 &&
                          validIcon6 &&
                          validIcon7 &&
                          tfController1.text.isNotEmpty) {
                        register();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor:
                              const Color.fromARGB(255, 36, 72, 101),
                          content: const Text("please enter all fields"),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom > 0
                    ? MediaQuery.of(context).viewInsets.bottom +
                        MediaQuery.of(context).size.height * 0.01
                    : 0,
              ),
            ],
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 20,
            child: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  LoginPage.pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.arrow_back))),
        responseLoading
            ? Container(
                color: Colors.black..withAlpha(125),
                child: const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
