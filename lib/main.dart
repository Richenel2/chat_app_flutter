import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/constantes/theme.dart';
import 'package:sms/providers/user_provider.dart';
import 'package:sms/screens/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Product Sans',
          textTheme: const TextTheme(bodyText2: MyFont.normal)),
      home: const Loading(),
    );
  }
}
