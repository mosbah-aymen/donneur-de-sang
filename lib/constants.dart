

import 'package:donneurs_de_sang/models/donneur.dart';
import 'package:donneurs_de_sang/models/service_sanitaire.dart';
import 'package:flutter/material.dart';

PageController loginControllerPage = PageController(initialPage: 0);
String donneurType='donneur',serviceSanitaireType="serviceSanitaire";
Donor? currentDonor;
ServiceSanitaire? currentServiceSanitaire;

Color primaryColor = Colors.red,
secondaryColor = Colors.cyan;