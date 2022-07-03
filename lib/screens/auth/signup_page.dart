import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController usernameConroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordConroller = TextEditingController();
  int initialIndex = 1;
  List countryCodes = ['mm','th'];

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);

  final usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'Username is required'),
    MinLengthValidator(4, errorText: 'Username must be at least 4 digits long'),
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

                  SizedBox(height: 50,),

                  ///country choose
                  // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                  // ToggleSwitch(
                  //   minWidth: deviseWidth * .90,
                  //   // minHeight: deviseWidth * .14,
                  //   activeBgColor: [Colors.green],
                  //   inactiveBgColor: Color(0xffE8E8E8),
                  //   initialLabelIndex: initialIndex,
                  //   totalSwitches: 2,
                  //   labels: ['🇲🇲 Myanmar ', '🇹🇭 Thailand ',],
                  //   onToggle: (index) {
                  //     print('switched to: $index');
                  //     initialIndex=index!;
                  //     setState(() {
                  //
                  //     });
                  //   },
                  // ),

                  ///Username container
                  Container(
                    width: deviseWidth * .90,
                    height: deviseWidth * .14,
                    margin: EdgeInsets.only(top: deviseWidth * .04,),
                    decoration: BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: usernameConroller,
                          style: TextStyle(
                            fontSize: deviseWidth * .040,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Username',
                          ),
                          validator: usernameValidator,
                        ),
                      ),
                    ),
                  ),

                  ///email container
                  Container(
                    margin: EdgeInsets.only(top: deviseWidth * .04,),
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

                  ///password container
                  Container(
                    width: deviseWidth * .90,
                    height: deviseWidth * .14,
                    margin: EdgeInsets.only(top: deviseWidth * .04,),
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

                  ///confrim password container
                  Container(
                    width: deviseWidth * .90,
                    height: deviseWidth * .14,
                    margin: EdgeInsets.only(top: deviseWidth * .04,bottom: deviseWidth * .04,),
                    decoration: BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // controller: passwordConroller,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: deviseWidth * .040,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Confirm Password',
                          ),
                          validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(val!, passwordConroller.text),
                        ),
                      ),
                    ),
                  ),

                  ///Sign up button
                  GestureDetector(
                    onTap: () {
                      print('fuckkkkkk');
                      if (formkey.currentState!.validate()) {
                        // context.read<AuthProvider>().signUp(countryCodes[initialIndex],usernameConroller.text, phoneController.text, passwordConroller.text);

                        context.read<AuthProvider>().signUp(country: countryCodes[initialIndex],username:usernameConroller.text,password: passwordConroller.text,phone: phoneController.text );
                      } else {
                        print('validation filed');
                      }
                    },
                    child: Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      margin: EdgeInsets.only(top: deviseWidth * .06,bottom: deviseWidth * .05,),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: deviseWidth * .040,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: deviseWidth * .040,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthProvider>().toggle(true);
                        },
                        child: Text(
                          'Sign in',
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
