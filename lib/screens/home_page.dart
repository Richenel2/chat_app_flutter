import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sms/api/request.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/constantes/toast.dart';
import 'package:sms/models/message_model.dart';
import 'package:sms/providers/user_provider.dart';
import 'package:sms/screens/loading.dart';
import 'package:sms/screens/settings.dart';
import 'package:sms/views/image_profil.dart';
import 'package:sms/views/message_view.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatelessWidget {
  final TextEditingController message = TextEditingController();
  final List<Message> data;

  // final ScrollController _scrollController = ScrollController();
  HomePage({Key? key, required this.data}) : super(key: key);
  final channel = WebSocketChannel.connect(
      Uri.parse('ws://kayrachat.herokuapp.com/mobile/'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.secondaryGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.secondaryGray,
        title: const Center(
            child: Text(
          'Chat app',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        )),
        leading: const Icon(
          Icons.keyboard_arrow_left_sharp,
          color: MyColor.primaryGreen,
        ),
        actions: [
          PopupMenuButton(
            icon: ImageProfil(user: context.read<UserProvider>().user!),
            onSelected: (value) async {
              if (value == 'logout') {
                await context.read<UserProvider>().user!.delete();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Loading()));
              }else if(value == 'update'){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()));
              }
            },
            itemBuilder: (_) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'update',
                child: Text('Update account'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Log out'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete account'),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: channel.stream,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  Toast.showAlertToast(snapshot.error.toString());
                }
                if (data.isEmpty && !snapshot.hasData) {
                  return const Center(
                    child: Text('Aucun messages pour l\'instant'),
                  );
                }
                if (snapshot.hasData) {
                  data.add(Message.fromMap(json.decode(snapshot.data!)));
                }
                return ListView.builder(
                    reverse: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) =>
                        MessageView(message: data[index])));
              },
            ),
          ),
          BottomAppBar(
            elevation: 3,
            child: Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: message,
                          decoration: const InputDecoration(
                            labelText: 'message',
                            icon: Icon(
                              Icons.insert_emoticon,
                              color: MyColor.primaryGreen,
                            ),
                          )),
                    ),
                    CircleAvatar(
                      backgroundColor: MyColor.primaryGreen,
                      child: IconButton(
                          onPressed: () async {
                            if (message.text.isNotEmpty) {
                              Api.instance.postMessage(
                                  creatorId:
                                      context.read<UserProvider>().user!.id,
                                  message: message.text);
                              message.text = '';
                            }
                          },
                          icon: const Icon(
                            Icons.near_me,
                            color: Colors.white,
                          )),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
