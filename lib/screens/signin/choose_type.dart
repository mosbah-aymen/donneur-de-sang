import 'package:donneurs_de_sang/constants.dart';
import 'package:flutter/material.dart';

import '../../components/flat_buttton.dart';
import 'login_donneur.dart';

class ChooseType extends StatefulWidget {
  const ChooseType({Key? key}) : super(key: key);

  @override
  _ChooseTypeState createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  int selectedType = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height+0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Select-pana.png',
                  height: 200,),
                  SizedBox(height: 50,),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Selectionner votre type : ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        selectedType = 0;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                            color: primaryColor,
                            width: selectedType == 0 ? 2 : 0.5)),
                    leading: const Icon(
                      Icons.bloodtype,
                      color: Colors.red,
                    ),
                    title: const Text('Donneur'),
                    trailing: Icon(
                      selectedType == 0 ? Icons.circle : Icons.circle_outlined,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        selectedType = 1;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                            color: primaryColor,
                            width: selectedType == 1 ? 2 : 0.5)),
                    leading: const Icon(
                      Icons.local_hospital,
                      color: Colors.red,
                    ),
                    title: const Text('Service Sanitaire'),
                    trailing: Icon(
                      selectedType == 1 ? Icons.circle : Icons.circle_outlined,
                      color: primaryColor,
                    ),
                  ),
                     const SizedBox(
                     height: 20,),
                  FlatButton(
                   onTap: (){
                   if(selectedType==0){
                     loginControllerPage.animateToPage(1, duration: const Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);
                   }
                   else{
                     loginControllerPage.animateToPage(2, duration: const Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);

                   }
                     },
                   text: 'Next',
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
        ),
      ),
    );
  }
}
