import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donneurs_de_sang/constants.dart';
import 'package:flutter/material.dart';

import '../models/rendez_vous.dart';

class RendezVousList extends StatelessWidget {
  final String? userId;

  const RendezVousList({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('List des rendez-vous'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('rendez_vous').where('donor.id', isEqualTo: userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.size==0) {
            return const Center(
              child: Text('aucun rendez-vous pour le moment'),
            );
          }

          final rendezVousDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: rendezVousDocs.length,
            itemBuilder: (BuildContext context, int index) {
              final rendezVousDoc = rendezVousDocs[index];
              final rendezVous = RendezVous.fromJson(rendezVousDoc.data() as Map<String, dynamic>);
              return ListTile(
                title: Text(rendezVous.dateTime.toString()),
                subtitle: Text('With ${rendezVous.serviceSanitaire.name}'),
                onTap: () {

                },
              );
            },
          );
        },
      ),
    );
  }
}