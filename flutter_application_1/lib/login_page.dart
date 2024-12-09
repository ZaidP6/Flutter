import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromARGB(255, 230, 48, 22),
      child: Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset('assets/images/path_logo.png'),
                  const Text('Beautiful, Private Sharing')
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Sign Up')),
                  const Text('Already have a Path account?'),
                  ElevatedButton(onPressed: () {}, child: const Text('Log In')),
                  const Text(
                      "By using Path, you agree to Path's Terms of Use and Privacy Policy.")
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
