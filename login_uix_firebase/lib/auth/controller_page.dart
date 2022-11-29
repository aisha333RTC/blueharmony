// ignore_for_file: prefer_const_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_page.dart';
import 'package:login_uix_firebase/pages/login/login_page.dart';
import 'package:login_uix_firebase/pages/main_page.dart';

import '../pages/dashboard_page.dart';
import '../pages/profile_page.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(snapshot.data?.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data?['markDeleted'] == false) {
                    if (snapshot.data?['roles'] != 'user') {
                      // Navigator.pushReplacementNamed(
                      print('aaaaaaaaaaaaaaaaaaaaa');
                      //     context,
                      //     DashboardPage.routeName);
                      return const DashboardPage();
                    } else {
                      print('bbbbbbbbbbbbbb');

                      // Navigator.pushReplacementNamed(
                      //     context, MainPage.routeName);

                      return const MainPage();
                    }
                  } else {
                    return Material(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            } else {
              print('cccccccccccccccc');
              return const LandingPage();
            }
          }),
    );
  }
}
