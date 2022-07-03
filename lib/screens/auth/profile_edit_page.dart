import 'package:flutter/material.dart';
import 'package:maymyanmar/models/user.dart';
import 'package:maymyanmar/providers/auth_provier.dart';
import 'package:maymyanmar/providers/cart_provider.dart';
import 'package:maymyanmar/theme/app_colors.dart';
import 'package:maymyanmar/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  User user;


  ProfileEditPage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late String userName=widget.user.name;
  late String userEmail=widget.user.email;
  late String userPhone=widget.user.phoneNumber;
  late String userAddress=widget.user.address??'';
  late String userCity= widget.user.city??'';
  late String userPostal = widget.user.postalCode??'';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close,color: Colors.black,), onPressed: () { Navigator.pop(context); },
          ),
          actions: [
            TextButton(onPressed: (){saveChanges();}, child: Text('Save',style: TextStyle(fontSize: 16),))
          ],
          title: Text(
            'Edit Info',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: white,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            // ProfileWidget(
            //   imagePath: user.imagePath,
            //   isEdit: true,
            //   onClicked: () async {},
            // ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: '${widget.user.name}',
              onChanged: (name) {
                userName= name;
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: '${widget.user.email}',
              onChanged: (email) {
                userEmail=email;
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Phone number',
              text: '${widget.user.phoneNumber}',
              onChanged: (phone) {
                userPhone=phone;
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Address',
              text: '${widget.user.address==null?'':widget.user.address}',
              maxLines: 4,
              onChanged: (address) {
                userAddress = address;
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'City',
              text: '${widget.user.city==null?'':widget.user.address}',
              onChanged: (city) {
                userCity = city;
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Postal Code',
              text: '${widget.user.postalCode==null?'':widget.user.postalCode}',
              onChanged: (postal) {
                userPostal = postal;
              },
            ),
            const SizedBox(height: 15),
            // Container(
            //   height: 50,
            //   child: TextButton(
            //     onPressed: () {
            //       saveChanges();
            //     },
            //     child: Text('Save',style: TextStyle(color: white),),
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(pink),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //           // side: BorderSide(color: Colors.red),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  saveChanges()async{
    print('ff');
    await Provider.of<AuthProvider>(context, listen: false).changeProfileInfo(userName, userEmail, userPhone, userAddress,userCity,userPostal);
    Navigator.pop(context);
    print('gg');
  }
}
