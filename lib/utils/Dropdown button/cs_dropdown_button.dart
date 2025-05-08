import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CSDropdownBTB extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final String selectItemText;
  final Function(String?) onSelected;


  const CSDropdownBTB({
    super.key,
    this.selectedValue,
    required this.items,
    required this.selectItemText,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          hint: Text(
            selectItemText,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          items:
              items
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            onSelected(value);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          menuItemStyleData: const MenuItemStyleData(height: 40),
        ),
      ),
    );
  }
}