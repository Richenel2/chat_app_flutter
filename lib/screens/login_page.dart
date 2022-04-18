import 'package:flutter/material.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/screens/home_page.dart';
import 'package:sms/views/custom_text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<GlobalKey<FormState>> key = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                            'Login',
                            style: MyFont.title,
                          ),
                          Text('Please login to continue')
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          CustomTextInput(
                            formkey: key[0],
                            text: 'email',
                            icon: Icons.mail_outline,
                            keyBoardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)) {
                                return 'Enter a valid email';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextInput(
                            formkey: key[1],
                            keyBoardType: TextInputType.visiblePassword,
                            validator: (val) {
                              if (val!.isEmpty || val.length<6) {
                                return 'Entrer un mot de passe valide';
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (key
                                  .map((e) => e.currentState!.validate())
                                  .fold(
                                      true,
                                      (previousValue, element) =>
                                          previousValue && element)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              }
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'Login',
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
                  const Text("Don't have an account? "),
                  TextButton(onPressed: () {}, child: const Text('SignIn'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
