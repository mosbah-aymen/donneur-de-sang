
// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donneurs_de_sang/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceSanitaireController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> createFirebaseAccount(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await      userCredential.user!.updateDisplayName(serviceSanitaireType);
      return userCredential.user!.uid;
    } catch (e) {


      Fluttertoast.showToast(msg: 'Error creating  account: $e',backgroundColor: primaryColor,gravity: ToastGravity.CENTER);

      return '';
    }
  }

}