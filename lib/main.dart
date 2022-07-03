import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/cart_provider.dart';
import 'package:maymyanmar/providers/exchange_provider.dart';
import 'package:maymyanmar/providers/home_provider.dart';
import 'package:maymyanmar/providers/news_provider.dart';
import 'package:maymyanmar/providers/order_provider.dart';
import 'package:maymyanmar/providers/search_provider.dart';
import 'package:maymyanmar/screens/auth/auth_page.dart';
import 'package:maymyanmar/screens/auth/signin_page.dart';
import 'package:maymyanmar/screens/auth/signup_page.dart';
import 'package:maymyanmar/screens/main_screen.dart';
import 'package:maymyanmar/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExchangeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    bool isAuth = context.watch<AuthProvider>().isAuth;
    bool isLoading = context.watch<AuthProvider>().loading;
    context.read<AuthProvider>().checkSignin();

    if (isLoading) {
      return MaterialApp(
        home: LoadingWidget(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isAuth ? MainScreen() : AuthPage(), // MainScreen(),
      );
    }
  }
}
