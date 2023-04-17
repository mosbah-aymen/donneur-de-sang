import 'package:donneurs_de_sang/components/FormFieldCustom.dart';
import 'package:flutter/material.dart';

class BloodTypeSelector extends StatelessWidget {
  final String? selectedBloodType;
  final List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final Function(String) onBloodTypeSelected;

  BloodTypeSelector({super.key, required this.onBloodTypeSelected,this.selectedBloodType='A+'});

  @override
  Widget build(BuildContext context) {
    return FieldCustom(
      title: 'Groupe sanguin',
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          underline: const SizedBox(),
          isExpanded: true,
          value: selectedBloodType,
          onChanged: (String? value) => onBloodTypeSelected(value!),
          items: bloodTypes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
