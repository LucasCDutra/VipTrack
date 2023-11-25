import 'package:flutter/material.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/domain/models/directions.dart';
import 'package:viptrack/screens/offer_ride/screen_offer_ride_details.dart';

Widget reviewRideBottomSheet(BuildContext context, String? distance, String? duration, int? durationInt) {
  SharedPref sharedPref = SharedPref();

  Directions source = sharedPref.getUserSourceDirection(isSource: true);
  Directions destination = sharedPref.getUserSourceDirection(isSource: false);

  String destinLoc = destination.address == null ? '$destination.locationName' : destination.address!.split(' - ')[0];
  String sourcecLoc = source.address == null ? '${source.locationName}' : source.address!.split(' - ')[0];

  Carona carona = Carona(
      origem: source.city,
      origemCompleto: sourcecLoc,
      destino: destination.city,
      destinoCompleto: destinLoc,
      duracao: duration,
      duracaoInt: durationInt,
      distancia: distance);

  String routeNamed = '$sourcecLoc ➡ $destinLoc';
  return Positioned(
    bottom: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(routeNamed, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.indigo)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons
                    .directions_car_filled), //const Image(image: AssetImage('assets/image/sport-car.png'), height: 50, width: 50),
                title: RichText(
                  text: TextSpan(
                    text: 'Distância: ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontSize: 15,
                    ),
                    children: [TextSpan(text: '$distance km', style: const TextStyle(fontWeight: FontWeight.bold))],
                  ),
                ),
                //Text('Distância', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: RichText(
                  text: TextSpan(
                    text: 'Tempo de viagem: ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontSize: 15,
                    ),
                    children: [TextSpan(text: '$duration', style: const TextStyle(fontWeight: FontWeight.bold))],
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OfferRideDetails(
                        carona: carona,
                        // distance: '$distance',
                        // duration: '$duration',
                        // sourcePlace: sourcecLoc,
                        // destinationPlace: destinLoc,
                      ),
                    )),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('OFERECER CARONA'),
                ])),
          ]),
        ),
      ),
    ),
  );
}
