import 'package:flutter/material.dart';

class StandardTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController textEditingController;
  final int? maxLines;
  const StandardTextField(
      {super.key,
      this.hintText,
      required this.textEditingController,
      this.maxLines});

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
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: TextField(
        maxLines: maxLines ?? 1,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(19))),
        ),
      ),
    );
  }
}
