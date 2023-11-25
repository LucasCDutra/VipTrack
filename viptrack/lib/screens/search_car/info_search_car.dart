import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/utils/formatters.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class InfoSearchCar extends StatelessWidget {
  final Carona carona;

  const InfoSearchCar({super.key, required this.carona});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 168, 168, 168).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(1, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color.fromARGB(179, 158, 158, 158), width: 1.5)),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${getSplitDataInfo(carona.data!, "d")}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 1,
                          ),
                        ),
                        Text(
                          '${getSplitDataInfo(carona.data!, "m")}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            height: 1,
                          ),
                        ),
                        Text(
                          '${getSplitDataInfo(carona.data!, "a")}',
                          style: const TextStyle(
                            height: 1,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${carona.origem ?? carona.origem}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: Color.fromARGB(255, 27, 71, 151),
                            fontSize: 17,
                          ),
                        ),
                        Container(
                          width: size.width * 0.6,
                          height: 1,
                          color: const Color.fromARGB(255, 201, 201, 201),
                        ),
                        Text(
                          '${carona.destino ?? carona.destinoCompleto}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: const Color.fromARGB(255, 21, 105, 25),
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${carona.horaInico}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 30,
                                  //right: ,
                                  child: Text(
                                    '${carona.duracao}',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                                const Icon(
                                  Icons.horizontal_rule_rounded,
                                  size: 100,
                                  color: Color.fromARGB(255, 211, 211, 211),
                                ),
                              ],
                            ),
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          TextSpan(
                            text: '${carona.horaFim}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 5),
                      child: Icon(Icons.person_4_rounded),
                    ),
                    Text(
                      formatFullName('${carona.motoristanome}'),
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        '${carona.valor}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: "whatsapp",
                  backgroundColor: Colors.green.shade800,
                  onPressed: () {
                    launchWhatsApp('${carona.motoristatelefone}');
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton.extended(
                  heroTag: "reservarcarona",
                  backgroundColor: Colors.black,
                  onPressed: () {},
                  label: const Text(
                    'Solicitar Reserva da Carona',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  launchWhatsApp(String numberPhone) async {
    String msg =
        "Olá ${formatFirstName(carona.motoristanome)}! \n Vim atráves do aplicativo VIPTrack, tenho interesse na carona do dia ${carona.data} \n ${carona.origem} para ${carona.destino} \n Com o valor de ${carona.valor}.";

    if (numberPhone != null) {
      final link = WhatsAppUnilink(
        phoneNumber: '+55 $numberPhone',
        text: msg,
      );
      await launch('$link');
    }
  }
}
