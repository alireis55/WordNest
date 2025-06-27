import 'package:flutter/material.dart';
import 'package:word_nest/core/services/register_service.dart';
import 'package:word_nest/core/models/request/request_register_model.dart';
import 'package:word_nest/UI/widgets/custom_snackbar.dart';
import 'package:word_nest/UI/utils/validators/validators.dart';
import 'package:word_nest/UI/widgets/custom_text_field.dart';
import 'package:word_nest/UI/widgets/custom_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:word_nest/UI/widgets/authorization_status_row.dart';
import 'package:word_nest/UI/view/auth/auth_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  FocusNode tfFocusNode1 = FocusNode();
  FocusNode tfFocusNode2 = FocusNode();
  FocusNode tfFocusNode3 = FocusNode();
  FocusNode tfFocusNode4 = FocusNode();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
    emailController.addListener(() {
      if (emailValidator(emailController.text) == null) {
        setState(() {
          validIcon1 = true;
        });
      } else {
        setState(() {
          validIcon1 = false;
        });
      }
    });
    passwordController.addListener(() {
      if (PasswordValidator.validate6Charecter(passwordController.text) ==
          null) {
        setState(() {
          validIcon2 = true;
        });
      } else {
        setState(() {
          validIcon2 = false;
        });
      }
      if (PasswordValidator.validateSpecialCharecter(passwordController.text) ==
          null) {
        setState(() {
          validIcon3 = true;
        });
      } else {
        setState(() {
          validIcon3 = false;
        });
      }
      if (PasswordValidator.validateUpperCase(passwordController.text) ==
          null) {
        setState(() {
          validIcon4 = true;
        });
      } else {
        setState(() {
          validIcon4 = false;
        });
      }
      if (PasswordValidator.validateLowerCase(passwordController.text) ==
          null) {
        setState(() {
          validIcon5 = true;
        });
      } else {
        setState(() {
          validIcon5 = false;
        });
      }
      if (PasswordValidator.validateNumber(passwordController.text) == null) {
        setState(() {
          validIcon6 = true;
        });
      } else {
        setState(() {
          validIcon6 = false;
        });
      }
    });
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
        tfController4.addListener(() {
          if (passwordController.text == tfController4.text &&
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
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
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
    context.loaderOverlay.show();
    try {
      final response = await RegisterService.register(RequestRegisterModel(
        username: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
      ));
      if (mounted) {
        CustomSnackBar.show(context, response.message!);
        AuthView.animateToPage(0);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.show(
            context, e.toString().replaceAll('Exception: ', ''));
      }
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: true,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: CustomTextField(
                    controller: userNameController,
                    hintText: 'Username',
                    focusNode: tfFocusNode1,
                    onChanged: (_) {},
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: CustomTextField(
                    controller: emailController,
                    hintText: 'E-mail',
                    focusNode: tfFocusNode2,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) {},
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
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    focusNode: tfFocusNode3,
                    obscureText: obscureText,
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
                    onChanged: (_) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthorizationStatusRow(
                          isValid: validIcon1, text: 'Valid email address'),
                      AuthorizationStatusRow(
                          isValid: validIcon2, text: 'At least 6 characters'),
                      AuthorizationStatusRow(
                          isValid: validIcon3,
                          text: 'At least 1 special character'),
                      AuthorizationStatusRow(
                          isValid: validIcon4,
                          text: 'At least 1 uppercase letter'),
                      AuthorizationStatusRow(
                          isValid: validIcon5,
                          text: 'At least 1 lowercase letter'),
                      AuthorizationStatusRow(
                          isValid: validIcon6, text: 'At least 1 number'),
                      AuthorizationStatusRow(
                          isValid: validIcon7, text: 'Confirm password'),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: CustomTextField(
                    controller: tfController4,
                    hintText: 'Confirm Password',
                    focusNode: tfFocusNode4,
                    obscureText: obscureText,
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
                    onChanged: (_) {},
                  ),
                ),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (validIcon1 &&
                        validIcon2 &&
                        validIcon3 &&
                        validIcon4 &&
                        validIcon5 &&
                        validIcon6 &&
                        validIcon7 &&
                        userNameController.text.isNotEmpty) {
                      register();
                    } else {
                      CustomSnackBar.show(context, "please enter all fields");
                    }
                  },
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
                    AuthView.animateToPage(0);
                  },
                  icon: const Icon(Icons.arrow_back))),
        ],
      ),
    );
  }
}
