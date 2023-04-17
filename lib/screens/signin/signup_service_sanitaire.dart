import 'package:donneurs_de_sang/constants.dart';
import 'package:donneurs_de_sang/models/service_sanitaire.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

import '../../components/FormFieldCustom.dart';
import '../../components/flat_buttton.dart';
import '../../controllers/service_sanitaire_crtl.dart';
import '../../global_functions.dart';
import '../home_screen.dart';
import 'login_donneur.dart';

class SignupServiceSanitaire extends StatefulWidget {
  const SignupServiceSanitaire({Key? key}) : super(key: key);

  @override
  SignupServiceSanitaireState createState() => SignupServiceSanitaireState();
}

class SignupServiceSanitaireState extends State<SignupServiceSanitaire> {
  double? latitude,longitude;
  TextEditingController nameCrtl = TextEditingController(),  emailCrtl = TextEditingController(), passwordCrtl = TextEditingController();
  String location='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,leading: IconButton(
          onPressed: (){
            loginControllerPage.animateToPage(0, duration:const Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);
          },
          icon: Icon(Icons.cancel_outlined,color: primaryColor,)),),
      body: SizedBox(
        height: MediaQuery.of(context).size.height*0.9,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Hospital building-amico.png',
                  height: 200,),
                const SizedBox(height: 50,),
                FieldCustom(
                  title: 'Nom de Service Sanitaire',
                  icon: Icons.local_hospital,
                  child: TextFormField(
                    controller: nameCrtl,
                    decoration: decoration('Nom de Service Sanitaire'),
                    keyboardType: TextInputType.name,
                  ),
                ),
                // SizedBox(
                //   height: 50,
                //   child: OutlinedButton(
                //       child: const Center(
                //         child: Icon(Icons.place_outlined),
                //       ),
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) {
                //               return PlacePicker(
                //                 resizeToAvoidBottomInset: true,
                //                 apiKey: "",
                //                 hintText: 'find_place',
                //                 searchingText: 'please_wait',
                //                 selectText: 'select_place',
                //                 outsideOfPickAreaText:'no_place',
                //                 initialPosition: LatLng(0, 0),
                //                 useCurrentLocation: true,
                //                 selectInitialPosition: true,
                //                 usePinPointingSearch: true,
                //                 usePlaceDetailSearch: true,
                //                 zoomGesturesEnabled: true,
                //                 zoomControlsEnabled: true,
                //                 automaticallyImplyAppBarLeading: true,
                //                 autocompleteLanguage: 'fr',
                //                 onPlacePicked: (PickResult result) {
                //                   setState(() {
                //                     latitude = double.parse(result.geometry!.location.lat.toStringAsFixed(2));
                //                     longitude = double.parse(result.geometry!.location.lng.toStringAsFixed(2));
                //                   });
                //                   Navigator.of(context).pop();
                //                 },
                //               );
                //             },
                //           ),
                //         );
                //       },
                //     ),
                //
                // ),
                FieldCustom(
                  title: 'Votre adresse',
                  icon: Icons.location_on_outlined,
                  child: FutureBuilder<String>(
                      future:getLocation() ,
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        else{
                          location=snapshot.data!;
                          return Text(location,maxLines: 2,overflow: TextOverflow.ellipsis,);
                        }
                  })
                ),
                const SizedBox(height: 20,),

                FieldCustom(
                  title: 'Email',
                  icon: Icons.email,
                  child: TextFormField(
                    controller: emailCrtl,
                    decoration: decoration('Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                const SizedBox(height: 20,),
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
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg:message,backgroundColor: primaryColor,gravity: ToastGravity.CENTER);
                    } else {
                      wait(context);
                      String uid = await ServiceSanitaireController.createFirebaseAccount(emailCrtl.text, passwordCrtl.text);
                      if (uid.isNotEmpty) {
                        ServiceSanitaire serviceSanitaire = ServiceSanitaire(
                            name: nameCrtl.text,
                            email: emailCrtl.text,
                            address: location,
                            createdAt: DateTime.now(),
                            id: uid,
                            lat: latitude??0,
                            long: longitude??0);

                        await  serviceSanitaire.createServiceSanitaire().then((value) {
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
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginDonneur()));
                    }, child: const Text('connecter')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ) ,
    );
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
        return "${placemarks.first.name} ${placemarks.first.subLocality} ${placemarks.first.locality} ${placemarks.first.administrativeArea}" ;
      }
    } catch (e) {
      return 'Error getting location: $e';
    }
  }

  String? findError() {
    return nameCrtl.text.isEmpty
        ? 'Le nom est obligatoire'
        : emailCrtl.text.isEmpty
        ? 'L\'adresse e-mail est obligatoire'
        : passwordCrtl.text.isEmpty
        ? 'Le mot de passe est obligatoire'
        : null;
  }

}
