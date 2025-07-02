import 'package:flutter/material.dart';
import 'package:word_nest/ui/views/home/navigation_view.dart';
import 'package:word_nest/core/cubits/cache_cubit.dart';
import 'package:word_nest/core/models/request/request_login_model.dart';
import 'package:word_nest/core/services/login_service.dart';
import 'package:word_nest/core/services/shared_preferences_service.dart';
import 'package:word_nest/ui/widgets/custom_snackbar.dart';
import 'package:word_nest/ui/widgets/custom_text_field.dart';
import 'package:word_nest/ui/widgets/custom_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:word_nest/ui/views/auth/auth_view.dart';
import 'package:word_nest/core/errors/custom_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/UI/utils/navigation_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  Future<void> _login() async {
    context.loaderOverlay.show();
    try {
      final response = await LoginService.login(RequestLoginModel(
        email: emailController.text,
        password: passwordController.text,
      ));
      if (rememberMe) {
        await SharedPrefsHelper.setToken(response.token);
      } else {
        if (mounted) {
          context.read<CacheCubit>().setToken(response.token);
        }
      }
      if (mounted) {
        NavigationHelper.pushReplacement(context, const NavigationView());
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              const SizedBox(
                  width: 508 * 0.3,
                  height: 417 * 0.3,
                  child: Image(image: AssetImage('assets/logo.png'))),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                hintText: 'E-mail',
                icon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                icon: const Icon(Icons.lock),
                isPasswordTextField: true,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text("Remember me")
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Login',
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (passwordController.text.isNotEmpty &&
                      emailController.text.isNotEmpty) {
                    await _login();
                  } else {
                    CustomSnackBar.show(context, "please enter all fields");
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't you have an account?"),
                  TextButton(
                    onPressed: () {
                      AuthView.animateToPage(1);
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
      ],
    );
  }
}
