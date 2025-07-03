import 'package:flutter/material.dart';
import 'package:word_nest/ui/utils/device_info.dart';
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
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            left: AppSizes.singleChildScrollPadding,
            right: AppSizes.singleChildScrollPadding,
            bottom: DeviceInfo(context).keyboardHeight * 0.75),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: AppSizes.spaceMedium,
                  ),
                  const SizedBox(
                    width: AppSizes.logoSize,
                    height: AppSizes.logoSize,
                    child: Image(image: AssetImage('assets/logo.png')),
                  ),
                  const SizedBox(height: AppSizes.spaceMedium),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'E-mail',
                    icon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSizes.spaceMedium),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    icon: const Icon(Icons.lock),
                    isPasswordTextField: true,
                  ),
                  const SizedBox(
                    height: AppSizes.spaceMedium,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: AppColors.white,
                        activeColor: AppColors.green,
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
                  const SizedBox(
                    height: AppSizes.spaceMedium,
                  ),
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
                  const SizedBox(
                    height: AppSizes.spaceMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't you have an account?"),
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
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
                  const SizedBox(
                    height: AppSizes.spaceMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
