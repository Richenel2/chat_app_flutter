import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sms/api/request.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/constantes/toast.dart';
import 'package:sms/models/user_model.dart';
import 'package:sms/providers/user_provider.dart';
import 'package:sms/screens/loading.dart';
import 'package:sms/screens/login_page.dart';
import 'package:sms/views/custom_text_input.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isSending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: const [
                    Positioned(
                      child: CircleAvatar(
                        radius: 60,
                      ),
                      top: -20,
                      right: -20,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Sign In',
                            style: MyFont.title,
                          ),
                          Text('Please Sign In to continue')
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        key: key,
                        child: Column(
                          children: [
                            CustomTextInput(
                              controller: email,
                              text: 'email',
                              icon: Icons.mail_outline,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)) {
                                  Toast.showAlertToast('Enter a valid email');
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextInput(
                              controller: pseudo,
                              text: 'pseudo',
                              icon: Icons.person,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  Toast.showAlertToast('Enter a valid pseudo');
                                  return 'Enter a valid pseudo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextInput(
                              controller: password,
                              text: 'password',
                              keyBoardType: TextInputType.visiblePassword,
                              validator: (val) {
                                if (val!.isEmpty || val.length < 6) {
                                  Toast.showAlertToast(
                                      'please enter minimum 6 caracters');
                                  return 'please enter minimum 6 caracters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextInput(
                              controller: confirmPassword,
                              text: 'confirm password',
                              keyBoardType: TextInputType.visiblePassword,
                              validator: (val) {
                                if (val!.isEmpty || val != password.text) {
                                  Toast.showAlertToast(
                                      'please write the same password');
                                  return 'please write the same password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      isSending
                          ? const Center(
                              child: SpinKitFadingFour(
                              color: MyColor.primaryGreen,
                            ))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (key.currentState!.validate()) {
                                      setState(() {
                                        isSending = true;
                                      });
                                      User? user = await Api.instance.signin(
                                          pseudo: pseudo.text,
                                          email: email.text,
                                          password: password.text);
                                      if (user != null) {
                                        await user.save().onError(
                                            (error, stackTrace) =>
                                                Toast.showAlertToast(
                                                    error.toString()));
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .setUser(user);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Loading()));
                                      }
                                      setState(() {
                                        isSending = false;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Sign In',
                                        style: MyFont.button,
                                      ),
                                      Icon(Icons.keyboard_arrow_right_sharp),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder()),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("have an account? "),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text('LogIn'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
