import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/services/maps_service.dart';
import 'package:viptrack/domain/models/directions.dart';
import 'package:viptrack/domain/models/predicted_places.dart';

import '../main.dart';

Widget searchListView(List responses, bool isResponseForDestination, TextEditingController destinationController,
    TextEditingController sourceController) {
  SharedPref sharedPref = SharedPref();
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: responses.length,
    itemBuilder: (BuildContext context, int index) {
      PredictedPlaces? p = responses[index];
      return Column(
        children: [
          ListTile(
            onTap: () async {
              String text = '${p?.main_text} - ${p?.secondary_text}'; //responses[index]['place'];
              Directions placeDirections = Directions();
              if (p?.place_id != null) placeDirections = await MapServices.getPlaceDiretionsDetails(p!.place_id!);

              if (isResponseForDestination) {
                // verifica se endereco é Origem ou destino
                sharedPref.setDirection(placeDirections, isSource: !isResponseForDestination);
                destinationController.text = text;
                // sharedPreferences.setString('destination', json.encode(responses[index]));
              } else {
                sharedPref.setDirection(placeDirections, isSource: !isResponseForDestination);
                sourceController.text = text;
                //sharedPreferences.setString('source', json.encode(responses[index]));
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            leading: const SizedBox(
              height: double.infinity,
              child: CircleAvatar(child: Icon(Icons.map)),
            ),
            //title: Text(responses[index]['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            //subtitle: Text(responses[index]['address'], overflow: TextOverflow.ellipsis),
            title: Text('${p?.main_text}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${p?.secondary_text}', overflow: TextOverflow.ellipsis),
          ),
          const Divider(),
        ],
      );
    },
  );
}
