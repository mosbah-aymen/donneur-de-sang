import 'package:flutter/material.dart';

import '../constants.dart';

class FlatButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
 final Color? color,textColor;
  const FlatButton({Key? key,this.onTap,this.text,this.color,this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color:color?? primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child:  Center(
          child: Text(
            text??'',
            style: TextStyle(color:textColor?? Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
