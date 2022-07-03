import 'package:flutter/material.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/screens/auth/signin_page.dart';
import 'package:maymyanmar/screens/auth/signup_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    bool showSignIn = context.watch<AuthProvider>().showSignIn;
    return Container(
      child: showSignIn?SigninPage():SignupPage(),
    );
  }
}
