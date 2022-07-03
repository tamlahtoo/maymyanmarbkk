import 'package:flutter/material.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        elevation: 0,
        title: Text('Contact Us'),
      ),
      body: ListView(
        children: [
          // Center(
          //   child: Image.asset(
          //     'assets/images/contact.jpg',
          //     // height: deviseWidth * .3,
          //   ),
          // ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Have any questions?',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Feel that tingling in your fingertips? That is the magical urge to contact us. We are just a tap away.',
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    var url =
                        'fb://facewebmodal/f?href=https://www.facebook.com/May-Myanmar-BKK-102418054864860/';
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/images/fb.png',),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Facebook',
                          style: TextStyle(color: Colors.black87),
                        )
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    var url =
                        'https://www.instagram.com/maymyanmar.bkk';
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Image.asset('assets/images/instagram.png',),
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Call us"),
      content: Container(
        height: 150,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                callNumber("0628541343");
              },
              child: Text("0628541343"),
            ),
            ElevatedButton(
              onPressed: () {
                callNumber("0628541343");
              },
              child: Text('0640659903'),
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
