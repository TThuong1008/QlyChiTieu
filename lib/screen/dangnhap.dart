import 'package:flutter/material.dart';
import 'package:qlmoney/widgets/formdn.dart';
import 'dangky.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key, required Null Function() onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/logo.png",
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SignForm(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/image/fb.jpg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/image/gg.jpg",
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const NoAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NoAccount extends StatelessWidget {
  const NoAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
