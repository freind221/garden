import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slick_garden/providers/drop_down_provider.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String title;
  final String check;
  const CustomDropDown({
    super.key,
    required this.items,
    required this.check,
    required this.title,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  //final List<String> items = ['Donor', 'Acceptor', 'Admin'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DropDownProvider>(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        // validator: (value) {
        //   if (value == null) {
        //     return 'Please Select Your Role.';
        //   }
        //   return null;
        // },
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
            if (widget.check == 'sowMonth') {
              provider.setSowMonth(selectedValue!);
            } else if (widget.check == 'cropMonth') {
              provider.setCropMonth(selectedValue!);
            }
          });
        },
        buttonHeight: 50,
        buttonWidth: 140,
        itemHeight: 40,

        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black26,
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
