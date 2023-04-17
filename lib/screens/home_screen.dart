// ignore_for_file: library_private_types_in_public_api

import 'package:donneurs_de_sang/components/flat_buttton.dart';
import 'package:donneurs_de_sang/constants.dart';
import 'package:donneurs_de_sang/screens/service_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'donneur_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.displayName == donneurType
                  ? const DonneurHome()
                  : FirebaseAuth.instance.currentUser!.displayName == serviceSanitaireType
                      ? const ServiceHome()
                      :  Scaffold(
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Error '),
                              FlatButton(
                                text: 'refresh',
                                onTap: (){
                                  setState(() {

                                  });
                                },
                              ),
                            ],
                          ),
                        );
  }
}
