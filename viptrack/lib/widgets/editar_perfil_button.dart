// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:viptrack/application/handlers/carona_handler.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/screens/base_screen.dart';
import 'package:viptrack/utils/functions/message_snackbar.dart';

class EditarPerfilButton extends StatelessWidget {
  final Function()? onPress;
  const EditarPerfilButton({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        backgroundColor: Colors.black,
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: onPress,
        label: const Text(
          'Editar',
          style: TextStyle(color: Colors.white),
        ));
  }
}
