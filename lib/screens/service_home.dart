import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donneurs_de_sang/models/service_sanitaire.dart';
import 'package:donneurs_de_sang/screens/list_des_rendez_vous.dart';
import 'package:donneurs_de_sang/screens/signin/login_donneur.dart';
import 'package:donneurs_de_sang/screens/signin/signup_service_sanitaire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ServiceHome extends StatefulWidget {
  const ServiceHome({Key? key}) : super(key: key);

  @override
  _ServiceHomeState createState() => _ServiceHomeState();
}

class _ServiceHomeState extends State<ServiceHome> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('services_sanitaires').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            currentServiceSanitaire = ServiceSanitaire.fromJson(snapshot.data!.data()!);
          }
          return !snapshot.hasData
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : SafeArea(
                  child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: primaryColor,
                    title: const Text('Admin'),
                  ),
                  drawer: Drawer(
                    child: ListView(
                      children: [
                        DrawerHeader(
                          padding: EdgeInsets.zero,
                          child: Image.asset(
                            'assets/images/bdm_facebook_og.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Accueil'),
                          onTap: () {
                            // Navigate to home screen
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.local_hospital),
                          title: const Text('Centres de Santé'),
                          onTap: () {
                            // Navigate to health centers screen
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.article),
                          title: const Text('Articles'),
                          onTap: () {
                            // Navigate to articles screen
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Paramètres'),
                          onTap: () {
                            // Navigate to settings screen
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Déconnexion'),
                          onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginDonneur()));
                            },
                        ),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'Bienvenue, ${currentServiceSanitaire!.name}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Que voulez-vous faire aujourd\'hui?',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            children: [
                              HomeScreenCard(
                                icon: Icons.schedule_rounded,
                                label: 'Demmandes de rendez-vous',
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RendezVousList(userId: null)));
                                },
                              ),
                              HomeScreenCard(
                                icon: Icons.local_hospital,
                                label: 'Trouver un centre de santé',
                                onPressed: () {
                                  // Navigate to health centers screen
                                },
                              ),
                              HomeScreenCard(
                                icon: Icons.person_search_rounded,
                                label: 'Chercher un donneur',
                                onPressed: () {
                                  // Navigate to articles screen
                                },
                              ),
                              HomeScreenCard(
                                icon: Icons.question_answer,
                                label: 'Questions fréquentes',
                                onPressed: () {
                                  // Navigate to FAQs screen
                                },
                              ),  HomeScreenCard(
                                icon: Icons.person_add,
                                label: 'Nouveau Admin',
                                onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupServiceSanitaire()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
        });
  }
}

class HomeScreenCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const HomeScreenCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
