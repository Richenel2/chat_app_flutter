import 'package:flutter/material.dart';
import 'package:sms/api/request.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/models/user_model.dart';

class ImageProfil extends StatelessWidget {
  final User user;
  const ImageProfil({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user.image == null || user.image!.isEmpty
        ? const CircleAvatar(
            backgroundColor: MyColor.primaryGreen,
            radius: 20,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ))
        : CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              '${Api.url}${user.image!}',
            ),
          );
  }
}
