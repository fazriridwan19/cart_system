import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/login_page.dart';

import 'models/boxes.dart';
import 'models/cart.dart';
import 'screens/navbar_screen.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<Item>(HiveBoxes.cart);
  runApp(const MyApp());
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
        primarySwatch: Colors.blue,
      ),
      home: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const MyLoginPage(),
      ),
    );
  }
}
