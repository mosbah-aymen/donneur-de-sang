


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donneurs_de_sang/models/donneur.dart';
import 'package:donneurs_de_sang/models/service_sanitaire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'constants.dart';

Future<LocationData?> getLocationData() async {
  try {
   return await Location().getLocation();
  } catch (e) {
      print('Error getting location: $e');
  }
  return null;
}

Future<String> login(String email, String password) async {
  try {
    // First, authenticate the user with their email and password
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if(userCredential.user!.displayName==donneurType){
      // Then, get the user data from Firestore
      DocumentSnapshot<Map<String,dynamic>> doc = await FirebaseFirestore.instance.collection('donors').doc(userCredential.user!.uid).get();

      if (doc.exists) {
        currentDonor=Donor.fromJson(doc.data()!);
      } else {
        throw Exception("User not found in Firestore");
      }
    }
    else{
      // Then, get the user data from Firestore
      DocumentSnapshot<Map<String,dynamic>> doc = await FirebaseFirestore.instance.collection('services_sanitaires').doc(userCredential.user!.uid).get();
      if (doc.exists) {
        currentServiceSanitaire=ServiceSanitaire.fromJson(doc.data()!);
      } else {
        throw Exception("User not found in Firestore");
      }
    }
return '';
  } catch (e) {
    // Handle any errors that occur during authentication or data retrieval
    // throw Exception("Failed to login");
    return e.toString();
  }
}

void wait(BuildContext context){
  showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator(),));

}

