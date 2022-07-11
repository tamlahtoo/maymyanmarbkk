import 'package:flutter/material.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    bool isVerify = context.watch<AuthProvider>().verify;
    context.read<AuthProvider>().checkVerification();

    return Scaffold(
      body: isVerify
          ? MainScreen()
          : ListView(
              children: [
                // Center(
                //   child: Image.asset(
                //     'assets/images/contact.jpg',
                //     // height: deviseWidth * .3,
                //   ),
                // ),
                SizedBox(height: 50,),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your account is not verified',
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'You account need to be verified before using. Please contact the admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '   Reach us:',
                        style: TextStyle(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'maymyanmar.bkk@gmail.com',
                          );
                          String url = params.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print('Could not launch $url');
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.send,
                                color: Colors.black87,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Mail us',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // showAlertDialog(context);
                          callNumber("0628541343");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.black87,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Give us a call',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '   Social Media:',
                        style: TextStyle(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var url = 'https://m.me/MayMyanmarBKK';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              universalLinksOnly: true,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/fb.png',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Facebook',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var url = 'https://www.instagram.com/maymyanmar.bkk';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              universalLinksOnly: true,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/instagram.png',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Instagram',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
  void callNumber(String number) async {
    if (await canLaunch("tel://$number")) {
      await launch("tel://$number");
    } else {
      print('Could not launch $number');
    }
  }
}
