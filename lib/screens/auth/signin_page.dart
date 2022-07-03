import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordConroller = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    double deviseWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90,
            ),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/maymyanmar.jpg',
                    height: deviseWidth * .3,
                  ),
                  SizedBox(
                    height: deviseWidth * .07,
                  ),

                  ///phone container
                  Container(
                    width: deviseWidth * .90,
                    height: deviseWidth * .14,
                    decoration: BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: phoneController,
                          style: TextStyle(
                            fontSize: deviseWidth * .040,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Phone Number',
                          ),
                          validator: RequiredValidator(errorText: 'Phone number is required'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviseWidth * .04,
                  ),

                  ///password container
                  Container(
                    width: deviseWidth * .90,
                    height: deviseWidth * .14,
                    decoration: BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordConroller,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: deviseWidth * .040,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Password',
                          ),
                          validator: passwordValidator,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviseWidth * .04,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<AuthProvider>().signIn(phoneController.text, passwordConroller.text);
                      } else {
                        print('validation filed');
                      }
                    },
                    child: Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviseWidth * .040,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviseWidth * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: deviseWidth * .040,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthProvider>().toggle(false);
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xff00258B),
                            fontSize: deviseWidth * .040,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
