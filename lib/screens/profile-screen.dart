import 'package:cipherx/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.1),
        toolbarHeight: size.height * 0.15,
        centerTitle: true,
        leadingWidth: size.width * 0.3,
        leading: containerWithRadius(Container(), Colors.transparent,
            Colors.purple, size.height * 0.1, size.height * 0.1),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Username \n",
              style: textStyle(Colors.black.withOpacity(0.5), 14)),
          TextSpan(
              text: auth.currentUser?.displayName,
              style: textStyle(Colors.black, 24))
        ])),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Container(
          height: size.height * 0.5,
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rowComponent(Icons.wallet, Colors.purple, "Account"),
              line(),
              rowComponent(Icons.settings, Colors.purple, "Settings"),
              line(),
              rowComponent(Icons.send_to_mobile, Colors.purple, "Export Data"),
              line(),
              rowComponent(Icons.logout_outlined, Colors.red, "Logout")
            ],
          ),
        ),
      ),
    );
  }

  Widget line() {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      height: 1,
    );
  }

  Widget rowComponent(IconData iconData, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 16, bottom: 16, right: 12),
      child: SizedBox(
        child: Row(
          children: [
            iconWidget(iconData, color),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: textStyle(Colors.black, 18),
            )
          ],
        ),
      ),
    );
  }
}
