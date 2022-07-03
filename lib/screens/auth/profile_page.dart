import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maymyanmar/main.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/screens/auth/contact_us_page.dart';
import 'package:maymyanmar/screens/auth/profile_edit_page.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:maymyanmar/widgets/profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
  }

  Future<void> _pullRefresh() async {
    await Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = context.watch<AuthProvider>().currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: pink,
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            // physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 20,
              ),
              ProfileWidget(
                name: currentUser.name,
                imagePath:
                    'https://cdn1.vectorstock.com/i/1000x1000/51/05/male-profile-avatar-with-brown-hair-vector-12055105.jpg',
                onClicked: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileEditPage(
                              user: currentUser,
                            )),
                  );
                },
              ),
              buildAbout('Phone number', currentUser.phoneNumber),
              buildAbout('City', currentUser.city),
              buildAbout('Address', currentUser.address),
              buildAbout('Postal Code', currentUser.postalCode),
              buildAbout('Email', currentUser.email),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          // await Provider.of<CartProvider>(context, listen: false).updateCart()
                          await context.read<AuthProvider>().signOut();
                          Restart.restartApp();
                        },
                        child: Text(
                          '   Log Out   ',
                          style: TextStyle(color: white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(pink),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 50,
                    width: 130,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsPage()),
                        );
                      },
                      child: Text(
                        '   Contact Us   ',
                        style: TextStyle(color: white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(String name, String email) => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            '$email',
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

// Widget buildUpgradeButton() => ButtonWidget(
//   text: 'Upgrade To PRO',
//   onClicked: () {},
// );
//
  Widget buildAbout(String title, var data) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              '$title',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            data == null
                ? Text(
                    "",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.4,
                    ),
                  )
                : Text(
                    "${data}",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.4,
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey,
            )
          ],
        ),
      );
}
