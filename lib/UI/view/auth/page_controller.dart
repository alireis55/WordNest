import 'package:flutter/material.dart';
import 'package:word_nest/UI/view/home/bottom_navigation_bar_page.dart';
import 'package:word_nest/UI/view/auth/login_page.dart';
import 'package:word_nest/UI/view/auth/registar_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:word_nest/core/token/token.dart';

class PageControllerPage extends StatefulWidget {
  const PageControllerPage({super.key});

  @override
  State<PageControllerPage> createState() => _PageControllerPageState();
}

class _PageControllerPageState extends State<PageControllerPage> {
  @override
  void initState() {
    super.initState();
    LoginPage.pageController = PageController(initialPage: 0);
    chechConnection();
    checkToken();
  }

  Future<void> chechConnection() async {
    setState(() {
      checkingConnection = true;
      isConnected = true;
    });
    await deneme();
    List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.none)) {
      setState(() {
        checkingConnection = false;
        isConnected = false;
      });
      Future.delayed(Duration.zero, () {
        notConnection();
      });
    } else {
      setState(() {
        checkingConnection = false;
        isConnected = true;
      });
    }
  }

  Future<void> checkToken() async {
    setState(() {
      checkingConnection = true;
    });
    if (await SharedPrefsHelper.getToken() == "") {
      setState(() {
        token = false;
      });
    } else {
      setState(() {
        token = true;
      });
    }
    setState(() {
      checkingConnection = false;
    });
  }

  Future<void> deneme() async {
    setState(() {
      checkingConnection = true;
      isConnected = true;
    });
  }

  bool token = false;

  void notConnection() {
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connection'),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 122, 199, 245),
                      Color.fromARGB(255, 50, 199, 245),
                      Color.fromARGB(255, 122, 199, 245)
                    ])),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    chechConnection();
                  },
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isConnected = true;
  bool checkingConnection = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/core/assets/background.png'),
                  fit: BoxFit.cover),
            ),
            child: checkingConnection
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : !isConnected
                    ? const Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ))
                    : token
                        ? const BottomNavigatorPage()
                        : PageView(
                            controller: LoginPage.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: const [LoginPage(), RegistarPage()],
                          ),
          ),
        ],
      ),
    );
  }
}
