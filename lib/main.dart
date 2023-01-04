import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slick_garden/providers/drop_down_provider.dart';
import 'package:slick_garden/providers/herbs_provider.dart';
import 'package:slick_garden/providers/user_provider.dart';
import 'package:slick_garden/providers/veg_rovider.dart';
import 'package:slick_garden/utilis/firebase.dart';
import 'package:slick_garden/utilis/firestore.dart';
import 'package:slick_garden/views/auth/login.dart';
import 'package:slick_garden/views/auth/sign_up.dart';
import 'package:slick_garden/views/chat_screen.dart';

import 'package:slick_garden/views/home.dart';
import 'package:slick_garden/views/main_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((_) => DropDownProvider())),
    ChangeNotifierProvider(create: ((_) => VegetableProvider())),
    ChangeNotifierProvider(create: ((_) => UserProvide())),
    ChangeNotifierProvider(create: ((_) => HerbsProvider())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            AuthMethods().setToProvider(context);

            return MainQuestion();
          }
          return MainQuestion();
        },
      ),
      routes: {
        MenuScreen.routeName: (context) => MenuScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        MainQuestion.routeName: (context) => const MainQuestion()
      },
    );
  }
}
