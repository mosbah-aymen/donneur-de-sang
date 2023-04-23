import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donneurs_de_sang/models/service_sanitaire.dart';

import 'donneur.dart';

class RendezVous {
  final String id;
  final Donor donor;
  final ServiceSanitaire serviceSanitaire;
  final DateTime dateTime;
  final DateTime createdAt;

  RendezVous({
    required this.id,
    required this.donor,
    required this.serviceSanitaire,
    required this.dateTime,
    required this.createdAt,
  });

  // Create a new rendez-vous document in Firestore
  Future<void> createRendezVous() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('rendez_vous').doc(id);
    await documentReference.set(toJson());
  }

  // Update an existing rendez-vous document in Firestore
  Future<void> updateRendezVous() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('rendez_vous').doc(id);
    await documentReference.update(toJson());
  }

  // Delete an existing rendez-vous document from Firestore
  Future<void> deleteRendezVous() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('rendez_vous').doc(id);
    await documentReference.delete();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'donor': donor.toJson(),
      'serviceSanitaire': serviceSanitaire.toJson(),
      'dateTime': dateTime.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static RendezVous fromJson(Map<String, dynamic> json) {
    return RendezVous(
      id: json['id'],
      donor: Donor.fromJson(json['donor']),
      serviceSanitaire: ServiceSanitaire.fromJson(json['serviceSanitaire']),
      dateTime: DateTime.parse(json['dateTime']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}