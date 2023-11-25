// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:viptrack/application/handlers/carona_handler.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/screens/base_screen.dart';
import 'package:viptrack/utils/functions/message_snackbar.dart';

class OferecerCaronaButton extends StatelessWidget {
  final Carona carona;
  const OferecerCaronaButton({super.key, required this.carona});

  @override
  Widget build(BuildContext context) {
    final CaronaHandler _caronaHandler = CaronaHandler();

    return FloatingActionButton.extended(
        backgroundColor: Colors.black,
        icon: const Icon(
          Icons.local_taxi,
          color: Colors.white,
        ),
        onPressed: () async {
          bool saveIsComplete = await _caronaHandler.saveCarona(carona);
          if (saveIsComplete) {
            message(
              context,
              saveIsComplete ? 'Carona salva com sucesso' : 'Erro ao salvar Carona!',
              saveIsComplete,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
          }
        },
        label: const Text(
          'OFERECER CARONA',
          style: TextStyle(color: Colors.white),
        ));
  }
}
