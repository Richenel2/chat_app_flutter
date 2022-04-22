import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/constantes/toast.dart';
import 'package:sms/providers/user_provider.dart';
import 'package:sms/views/custom_text_input.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  bool isSending = false;

  @override
  void initState() {
    email.text = Provider.of<UserProvider>(context, listen: false).user!.email;
    pseudo.text = Provider.of<UserProvider>(context, listen: false).user!.pseudo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'Chat app',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        )),
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: const Icon(
            Icons.keyboard_arrow_left_sharp,
            color: MyColor.primaryGreen,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.linear_scale,
              color: MyColor.primaryGreen,
            ),
            onSelected: (value) {},
            itemBuilder: (_) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'save',
                child: Text('Save'),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(),
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
                                      await Provider.of<UserProvider>(context,
                                              listen: false)
                                          .update(
                                              email: email.text,
                                              pseudo: pseudo.text);
                                      setState(() {
                                        isSending = false;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Update',
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
            ],
          ),
        ),
      ),
    );
  }
}
