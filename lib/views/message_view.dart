import 'package:flutter/material.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/models/message_model.dart';
import 'package:provider/provider.dart';
import 'package:sms/models/user_model.dart';
import 'package:sms/providers/user_provider.dart';
import 'package:sms/views/image_profil.dart';

class MessageView extends StatelessWidget {
  final Message message;
  const MessageView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMyMessage =
        message.creatorId == context.read<UserProvider>().user!.id;
    return isMyMessage
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 58, 184, 88),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: MyColor.primaryGray.withOpacity(0.15),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(3, 3),
                      )
                    ]),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                margin: const EdgeInsets.all(8),
                child: Text(
                  message.message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageProfil(
                    user: context.read<UserProvider>().user!),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageProfil(
                    user: User(id: 1, pseudo: 'pseudo', email: 'email')),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: MyColor.primaryGray.withOpacity(0.15),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(3, 3),
                      )
                    ]),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                margin: const EdgeInsets.all(8),
                child: Text(
                  message.message,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
  }
}
