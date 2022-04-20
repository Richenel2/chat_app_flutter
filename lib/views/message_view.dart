import 'package:flutter/material.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/models/message_model.dart';
import 'package:provider/provider.dart';
import 'package:sms/providers/user_provider.dart';

class MessageView extends StatelessWidget {
  final Message message;
  const MessageView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMyMessage =
        message.creatorId == context.read<UserProvider>().user!.id;
    return Row(
      mainAxisAlignment:
          isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(),
        ),
        Container(
          decoration: BoxDecoration(
              color: isMyMessage ? MyColor.primaryGreen : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: MyColor.primaryGray.withOpacity(0.15),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(3, 3),
                )
              ]),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          margin: const EdgeInsets.all(8),
          child: Text(
            message.message,
            style: TextStyle(
              color: isMyMessage ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
