import 'package:donneurs_de_sang/constants.dart';
import 'package:donneurs_de_sang/controllers/donor_crtl.dart';
import 'package:donneurs_de_sang/global_functions.dart';
import 'package:donneurs_de_sang/models/donneur.dart';
import 'package:donneurs_de_sang/screens/home_screen.dart';
import 'package:donneurs_de_sang/screens/signin/login_donneur.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import '../../components/FormFieldCustom.dart';
import '../../components/flat_buttton.dart';
import '../../components/select_blood_type.dart';

class SignupDonneur extends StatefulWidget {
  const SignupDonneur({Key? key}) : super(key: key);

  @override
  _SignupDonneurState createState() => _SignupDonneurState();
}

class _SignupDonneurState extends State<SignupDonneur> {
  String? selectedBloodType = 'A+';
  TextEditingController nameCrtl = TextEditingController(), prenomCrtl = TextEditingController(), emailCrtl = TextEditingController(), phoneCrtl = TextEditingController(), passwordCrtl = TextEditingController();

  String location = '';

  DateTime? birthdate ;

  double? latitude, longitude;
  void _onBloodTypeSelected(String bloodType) {
    setState(() {
      selectedBloodType = bloodType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.99,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/Mobile wireframe-cuate.png',
                  height: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                FieldCustom(
                  title: 'Nom',
                  icon: Icons.person,
                  child: TextFormField(
                    decoration: decoration('Nom'),
                    controller: nameCrtl,
                    keyboardType: TextInputType.name,
                  ),
                ),
                FieldCustom(
                  title: 'Prénom',
                  icon: Icons.person,
                  child: TextFormField(
                    controller: prenomCrtl,
                    decoration: decoration('Prénom'),
                    keyboardType: TextInputType.name,
                  ),
                ),
                FieldCustom(
                  title: 'Date de naissance',
                  icon: Icons.date_range_rounded,
                  onPressed: ()async{
                    birthdate=await showDatePicker(context: context, initialDate:birthdate?? DateTime.now()
                        , firstDate: DateTime(1900), lastDate: DateTime.now());
                    setState(() {});
                  },
                  child: Text(birthdate==null?"Date de naissance":birthdate.toString().substring(0,10)),
                ),
                const SizedBox(
                  height: 20,
                ),
                BloodTypeSelector(
                  selectedBloodType: selectedBloodType,
                  onBloodTypeSelected: _onBloodTypeSelected,
                ),
                const SizedBox(
                  height: 20,
                ),
                FieldCustom(
                  title: 'Téléphone',
                  icon: Icons.phone,
                  child: TextFormField(
                    controller: phoneCrtl,
                    decoration: decoration('Téléphone'),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                FieldCustom(
                  title: 'Email',
                  icon: Icons.email,
                  child: TextFormField(
                    controller: emailCrtl,
                    decoration: decoration('Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                FieldCustom(
                  title: 'Mot de passe',
                  icon: Icons.lock,
                  child: TextFormField(
                    controller: passwordCrtl,
                    decoration: decoration('mot de passe'),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FlatButton(
                  text: "Sign up",
                  onTap: () async {
                    String? message = findError();
                    if (message != null) {
                      Fluttertoast.showToast(msg:message,backgroundColor: primaryColor,gravity: ToastGravity.CENTER);
                    } else {
                      wait(context);
                      String uid = await DonneurController.createFirebaseAccount(emailCrtl.text, passwordCrtl.text);
                      if (uid.isNotEmpty) {
                        Donor donor = Donor(
                            name: nameCrtl.text,
                            lastName: prenomCrtl.text,
                            birthDate: birthdate!,
                            bloodGroup: selectedBloodType!,
                            phone: phoneCrtl.text,
                            email: emailCrtl.text,
                            address: '',
                            creationDate: DateTime.now(),
                            id: uid,
                            latitude: latitude??0,
                            longitude: longitude??0);
                        await  donor.createDonor().then((value) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                        });
                      }
                    }
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('vous avez un compte?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginDonneur()));
                        },
                        child: const Text('connecter')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? findError() {
    return nameCrtl.text.isEmpty
        ? 'Le nom est obligatoire'
        : prenomCrtl.text.isEmpty
            ? 'Le prénom est obligatoire'
            : birthdate==null?
        'Merci de selectionner votre date de naissance'
        : emailCrtl.text.isEmpty
                ? 'L\'adresse e-mail est obligatoire'
                : phoneCrtl.text.isEmpty
                    ? 'Le numéro de téléphone est obligatoire'
                    : passwordCrtl.text.isEmpty
                        ? 'Le mot de passe est obligatoire'
                        : null;
  }

  Future<String> getLocation() async {
    try {
      LocationData? position = await getLocationData();
      if(position==null){
        return 'error';
      }
      else{

        latitude = position.latitude;
        longitude = position.longitude;
        setState(() {});
        List<Placemark> placemarks =  await placemarkFromCoordinates(latitude!, longitude!);
        return placemarks.first.toString();
      }
    } catch (e) {
      return 'Error getting location: $e';
    }
  }
}
