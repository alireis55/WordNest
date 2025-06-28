import 'package:flutter/material.dart';
import 'package:word_nest/core/errors/custom_exception.dart';
import 'package:word_nest/core/services/register_service.dart';
import 'package:word_nest/core/models/request/request_register_model.dart';
import 'package:word_nest/ui/views/auth/auth_view.dart';
import 'package:word_nest/ui/widgets/custom_snackbar.dart';
import 'package:word_nest/ui/utils/validators/validators.dart';
import 'package:word_nest/ui/widgets/custom_text_field.dart';
import 'package:word_nest/ui/widgets/custom_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:word_nest/ui/widgets/custom_back_button.dart';
import 'package:word_nest/ui/widgets/validity_status_row.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  List<bool> validations = List.filled(7, false);

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
    confirmPasswordController.addListener(_validateConfirmPassword);
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final isValid = emailValidator(emailController.text) == null;
    if (validations[0] != isValid) {
      setState(() {
        validations[0] = isValid;
      });
    }
  }

  void _validatePassword() {
    final newValidations = [
      PasswordValidator.validate6Charecter(passwordController.text) == null,
      PasswordValidator.validateSpecialCharecter(passwordController.text) ==
          null,
      PasswordValidator.validateUpperCase(passwordController.text) == null,
      PasswordValidator.validateLowerCase(passwordController.text) == null,
      PasswordValidator.validateNumber(passwordController.text) == null,
    ];

    bool needsUpdate = false;
    for (int i = 0; i < 5; i++) {
      if (validations[i + 1] != newValidations[i]) {
        validations[i + 1] = newValidations[i];
        needsUpdate = true;
      }
    }

    if (needsUpdate) {
      setState(() {});
    }
  }

  void _validateConfirmPassword() {
    final isValid = passwordController.text == confirmPasswordController.text &&
        confirmPasswordController.text.isNotEmpty;
    if (validations[6] != isValid) {
      setState(() {
        validations[6] = isValid;
      });
    }
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
    } on CustomException catch (e) {
      if (mounted) {
        CustomSnackBar.show(context, e.toString());
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.show(context, 'Undefined Error');
      }
    }
    if (mounted) {
      context.loaderOverlay.hide();
    }
  }

  bool get _isFormValid =>
      validations.every((v) => v) && userNameController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              CustomTextField(
                controller: userNameController,
                hintText: 'Username',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                hintText: 'E-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ValidityStatusRow(
                  isValid: validations[0], text: 'Valid email adress'),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                isPasswordTextField: true,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValidityStatusRow(
                      isValid: validations[1], text: 'At least 6 characters'),
                  ValidityStatusRow(
                      isValid: validations[2],
                      text: 'At least 1 special character'),
                  ValidityStatusRow(
                      isValid: validations[3],
                      text: 'At least 1 uppercase letter'),
                  ValidityStatusRow(
                      isValid: validations[4],
                      text: 'At least 1 lowercase letter'),
                  ValidityStatusRow(
                      isValid: validations[5], text: 'At least 1 number'),
                  ValidityStatusRow(
                      isValid: validations[6], text: 'Confirm password'),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                isPasswordTextField: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_isFormValid) {
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
        CustomBackButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            AuthView.animateToPage(0);
          },
        ),
      ],
    );
  }
}
