import 'package:flutter/material.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/views/custom_text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Login',
                        style: MyFont.title,
                      ),
                      Text('Please login to continue')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: const [
                      CustomTextInput(
                        text: 'email',
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(onPressed: () {}, child: const Text('SignIn'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
