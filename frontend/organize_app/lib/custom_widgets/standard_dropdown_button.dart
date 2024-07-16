import 'package:flutter/material.dart';

class StandardDropdownButton extends StatelessWidget {
  final String? hintText;
  final String? selectedItem;
  final List<String> listItems;
  final Function(String?) function;
  const StandardDropdownButton({
    super.key,
    this.hintText,
    this.selectedItem,
    required this.listItems,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 1,
                spreadRadius: -18,
                offset: Offset(0, 23))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.grey, width: 1)),
      child: DropdownButton<String>(
        padding: EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 10),
        isExpanded: true,
        underline: Container(),
        value: selectedItem,
        hint: Text("| $hintText" ?? "| Select an Item"),
        items: listItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: function,
      ),
    );
  }
}
