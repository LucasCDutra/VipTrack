import 'package:flutter/material.dart';
import 'package:viptrack/utils/constants.dart';
import 'package:viptrack/widgets/widgets.dart';

class RoundedInputField extends StatefulWidget {
  final String? hintText;
  final IconData icon;
  final TextEditingController textController;
  final bool isSecret;

  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.isSecret = false,
    required this.textController,
  }) : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool isObscure = false;

  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.textController,
        cursorColor: kPrimaryColor,
        obscureText: isObscure,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: kPrimaryColor),
                )
              : null,
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontFamily: 'OpenSans'),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
