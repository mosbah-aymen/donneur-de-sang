import 'package:donneurs_de_sang/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/donneur.dart';

class DonorProfilePage extends StatefulWidget {
  final Donor donor;

  const DonorProfilePage({Key? key, required this.donor}) : super(key: key);

  @override
  State<DonorProfilePage> createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Mon profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nom',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.donor.name,
                onChanged: (s){
                  widget.donor.name=s;
                  setState((){});
                },
                onFieldSubmitted: (s)async{
                  await widget.donor.updateDonor().then((value) {
                    Navigator.pop(context);
                  });
                },
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Prénom',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.donor.lastName,
                onChanged: (s){
                  widget.donor.lastName=s;
                  setState((){});
                },
                onFieldSubmitted: (s)async{
                  await widget.donor.updateDonor().then((value) {
                    Navigator.pop(context);
                  });
                },
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Addresse',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.donor.address,
                onChanged: (s){
                  widget.donor.address=s;
                  setState((){});
                },
                onFieldSubmitted: (s)async{
                  await widget.donor.updateDonor().then((value) {
                    Navigator.pop(context);
                  });
                },
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Numéro de téléphone',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.donor.phone,
                onChanged: (s){
                  widget.donor.phone=s;
                  setState((){});
                },
                onFieldSubmitted: (s)async{
                  await widget.donor.updateDonor().then((value) {
                    Navigator.pop(context);
                  });
                },
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Adresse e-mail',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.donor.email,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Date de naissance',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('dd/MM/yyyy').format(widget.donor.birthDate),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Groupe sanguin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.donor.bloodGroup,
                style: const TextStyle(fontSize: 18),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
