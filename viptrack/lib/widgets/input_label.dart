import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputLabel extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final Function()? onEditingComplete;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  const InputLabel({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.onEditingComplete,
    required this.keyboardType,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          TextField(
            controller: controller,
            onEditingComplete: () {
              onEditingComplete;
              FocusScope.of(context).unfocus();
            },
            keyboardType: keyboardType,
            inputFormatters: inputFormatter ?? [],
            decoration: InputDecoration(
              constraints: const BoxConstraints(maxHeight: 50),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
