import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donneurs_de_sang/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Donor {
  String name;
  String lastName;
  String bloodGroup;
  String phone;
  String email;
  String address;
  String id;
  DateTime birthDate;
  DateTime creationDate;
  double latitude;
  double longitude;

  Donor({
    required this.name,
    required this.lastName,
    required this.bloodGroup,
    required this.phone,
    required this.email,
    required this.address,
    required this.id,
    required this.birthDate,
    required this.creationDate,
    required this.latitude,
    required this.longitude,
  });

  // Create a new donor document in Firestore
  Future<void> createDonor() async {
    try{
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference documentReference = firestore.collection('donors').doc(id);
      await documentReference.set(toJson());
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString(),gravity: ToastGravity.CENTER,backgroundColor: primaryColor);
    }
  }

  // Update an existing donor document in Firestore
  Future<void> updateDonor() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('donors').doc(id);
    await documentReference.update(toJson());
  }

  // Delete an existing donor document from Firestore
  Future<void> deleteDonor() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection('donors').doc(id);
    await documentReference.delete();
  }



  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'bloodGroup': bloodGroup,
      'phone': phone,
      'email': email,
      'address': address,
      'id': id,
      'birthDate':birthDate,
      'creationDate': Timestamp.fromDate(creationDate),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static Donor fromJson(Map<String, dynamic> json) {
    return Donor(
      name: json['name'],
      lastName: json['lastName'],
      bloodGroup: json['bloodGroup'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      id: json['id'],
      birthDate:json['birthDate'].toDate(),
      creationDate: (json['creationDate'] as Timestamp).toDate(),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
