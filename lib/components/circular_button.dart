import 'package:donneurs_de_sang/constants.dart';
import 'package:flutter/material.dart';


class CircularButton extends StatelessWidget {
  final Color? borderColor, fillColor;
  final Widget? child;
  final double? radius, thickness, margin, padding;
  final Function()? onTap;

  const CircularButton({
    Key? key,
    this.borderColor,
    this.fillColor,
    this.child,
    this.radius,
    this.thickness,
    this.margin,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: primaryColor.withOpacity(0.6),
      borderRadius: BorderRadius.circular(30000),
      child: Container(
        height: radius ?? 40,
        width: radius ?? 40,
        padding: EdgeInsets.all(padding ?? 4),
        margin: EdgeInsets.all(margin ?? 4),
        decoration: BoxDecoration(
          color: fillColor,
          border: Border.all(
            width: thickness ?? 2,
            color: borderColor ?? Colors.black,
          ),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
