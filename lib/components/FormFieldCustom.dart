import 'package:flutter/material.dart';

import '../constants.dart';

class FieldCustom extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Widget? child;
  final double? height;
  final Color? textColor,borderColor;
  final Function()? onPressed;

  final bool? isRequired;
  const FieldCustom(
      {Key? key,
       this.icon,
       this.title,
      this.child,
        this.isRequired,
      this.height,
        this.textColor,
        this.borderColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       title==null?
           const SizedBox(): Padding(
          padding: const EdgeInsets.all(8),
          child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                         isRequired==true? const Text('*Obligatoire',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                          ),):const SizedBox()
                        ],
                      ),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            height: height ?? 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor??Colors.grey, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: title == 'Description'
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                icon!=null?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color:borderColor??primaryColor,
                  ),
                ):const SizedBox(),
                Expanded(child: child ?? const SizedBox()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
InputDecoration decoration(String? hint,
    {String? prefix, String? suffix, Color? prefixColor, Color? textColor,bool showBorder=false,}) =>
    InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14),
      counterText: '',
      prefixText: prefix,
      suffixText: suffix,
      suffixStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      prefixStyle: TextStyle(
          color: prefixColor ?? Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold),
      border:  OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder?Colors.black: Colors.transparent,
          )),
      enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder?Colors.black: Colors.transparent,
          )),
      disabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder?Colors.black: Colors.transparent,
          )),
      focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder?Colors.black: Colors.transparent,
          )),
    );