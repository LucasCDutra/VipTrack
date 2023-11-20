import 'package:flutter/material.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/directions.dart';

Widget reviewRideBottomSheet(BuildContext context, String? distance, String? dropOffTime) {
  SharedPref sharedPref = SharedPref();

  Directions source = sharedPref.getUserSourceDirection(isSource: true);
  Directions destination = sharedPref.getUserSourceDirection(isSource: false);

  return Positioned(
    bottom: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text('${source.locationName ?? source.address} ➡ ${destination.locationName ?? destination.address}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.indigo)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons
                    .directions_car_filled), //const Image(image: AssetImage('assets/image/sport-car.png'), height: 50, width: 50),
                title: const Text('Premier', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('$distance km, $dropOffTime drop off'),
                trailing: const Text('\$384.22', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            ElevatedButton(
                onPressed: () => {}, //Navigator.push(context, MaterialPageRoute(builder: (_) => const TurnByTurn())),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Start your premier ride now'),
                ])),
          ]),
        ),
      ),
    ),
  );
}
