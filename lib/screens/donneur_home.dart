import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donneurs_de_sang/components/circular_button.dart';
import 'package:donneurs_de_sang/screens/donor_profile.dart';
import 'package:donneurs_de_sang/screens/signin/login_donneur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import '../models/donneur.dart';

class DonneurHome extends StatefulWidget {
  const DonneurHome({Key? key}) : super(key: key);

  @override
  _DonneurHomeState createState() => _DonneurHomeState();
}

class _DonneurHomeState extends State<DonneurHome> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('donors').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            currentDonor = Donor.fromJson(snapshot.data!.data()!);
          }
          return !snapshot.hasData
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : SafeArea(
                  child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Donneur Home'),
                    backgroundColor: primaryColor,
                    actions: [
                      CircularButton(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'donate (not available yet)');
                        },
                        fillColor: Colors.white,
                        borderColor: Colors.white,
                        child: Icon(
                          Icons.bloodtype_outlined,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  drawer: Drawer(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DrawerHeader(
                                padding: EdgeInsets.zero,
                                child: Image.asset(
                                  'assets/images/bdm_facebook_og.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: const Text('Profil'),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DonorProfilePage(donor: currentDonor!)));
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.history),
                                title: const Text('Historique des dons'),
                                onTap: () {
                                  // TODO: Navigate to Donation history page
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.settings),
                                title: const Text('Paramètres'),
                                onTap: () {
                                  // TODO: Navigate to Settings page
                                },
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginDonneur()));
                          },
                          leading: Icon(Icons.logout),
                          title: const Text('Deconnecter'),
                        )
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'Bienvenue, ${currentDonor!.name}!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Trouvez une collecte de sang près de chez vous',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
// Naviguer vers l'écran de collecte de sang
                          },
                          child: const Text('Parcourir les collectes de sang'),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Actions rapides',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuickActionCard(
                              icon: Icons.schedule,
                              label: 'Prendre rendez-vous',
                              onPressed: () {
// Naviguer vers l'écran de prise de rendez-vous
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.bookmark,
                              label: 'Mes rendez-vous',
                              onPressed: () {
// Naviguer vers l'écran des rendez-vous
                              },
                            ),
                            QuickActionCard(
                              icon: Icons.favorite,
                              label: 'Mes dons',
                              onPressed: () {
// Naviguer vers l'écran des dons
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
        });
  }
}

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const QuickActionCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
