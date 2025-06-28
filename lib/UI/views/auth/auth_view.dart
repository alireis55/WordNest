import 'package:flutter/material.dart';
import 'package:word_nest/UI/views/auth/login_view.dart';
import 'package:word_nest/UI/views/auth/register_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  static late PageController pageController;

  static void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    super.initState();
    AuthView.pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    AuthView.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AuthBackground(
        child: PageView(
          controller: AuthView.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [LoginView(), RegisterView()],
        ),
      ),
    );
  }
}

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
