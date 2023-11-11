import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:viptrack/models/predicted_places.dart';

import '../main.dart';

Widget searchListView(List responses, bool isResponseForDestination, TextEditingController destinationController,
    TextEditingController sourceController) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: responses.length,
    itemBuilder: (BuildContext context, int index) {
      PredictedPlaces? p = responses[index];
      return Column(
        children: [
          ListTile(
            onTap: () {
              String text = '${p?.main_text}'; //responses[index]['place'];
              if (isResponseForDestination) {
                destinationController.text = text;
                sharedPreferences.setString('destination', json.encode(responses[index]));
              } else {
                sourceController.text = text;
                sharedPreferences.setString('source', json.encode(responses[index]));
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
