import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceSanitaire {
  String name;
  String email;
  String address;
  double lat;
  double long;
  String id;
  DateTime createdAt;

  ServiceSanitaire({
    required this.name,
    required this.email,
    required this.address,
    required this.lat,
    required this.long,
    required this.id,
    required this.createdAt
  });


  // Create a new service sanitaire document in Firestore
  Future<void> createServiceSanitaire() async {
  await  FirebaseFirestore.instance.collection('services_sanitaires').doc(id).set(toJson());
  }

  // Update an existing service sanitaire document in Firestore
  Future<void> updateServiceSanitaire() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('services_sanitaires').doc(id);
    await documentReference.update(toJson());
  }

  // Delete an existing service sanitaire document from Firestore
  Future<void> deleteServiceSanitaire() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('services_sanitaires').doc(id);
    await documentReference.delete();
  }

  // Get a list of all service sanitaire documents from Firestore
  static Future<List<ServiceSanitaire>> getServiceSanitaires() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('services_sanitaires').get();
    List<ServiceSanitaire> services = querySnapshot.docs.map((doc) {
      return ServiceSanitaire.fromJson(doc.data() as Map<String, dynamic>)..id = doc.id;
    }).toList();
    return services;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'lat': lat,
      'long': long,
      'id': id,
      'createdAt': createdAt
    };
  }

  static ServiceSanitaire fromJson(Map<String, dynamic> json) {
    return ServiceSanitaire(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      lat: json['lat'],
      long: json['long'],
      id: json['id'],
      createdAt: json['createdAt'].toDate(),
    );
  }
}
