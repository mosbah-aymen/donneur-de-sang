// ignore_for_file: library_private_types_in_public_api

import 'package:donneurs_de_sang/screens/signin/choose_type.dart';
import 'package:donneurs_de_sang/screens/signin/signup_donneur.dart';
import 'package:donneurs_de_sang/screens/signin/signup_service_sanitaire.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
class SigupContainer extends StatefulWidget {
  const SigupContainer({Key? key}) : super(key: key);

  @override
  _SigupContainerState createState() => _SigupContainerState();
}

class _SigupContainerState extends State<SigupContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: loginControllerPage,
          children: const [
            ChooseType(),
            SignupDonneur(),
            SignupServiceSanitaire(),
          ],
        ),
      ),
    );
  }
}
