import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viptrack/application/handlers/carona_handler.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/utils/formatters.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class InfoSearchCar extends StatefulWidget {
  final Carona carona;
  final bool historico;

  const InfoSearchCar({super.key, required this.carona, this.historico = false});

  @override
  State<InfoSearchCar> createState() => _InfoSearchCarState();
}

class _InfoSearchCarState extends State<InfoSearchCar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SharedPref sharedPref = SharedPref();

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
                          '${getSplitDataInfo(widget.carona.data!, "d")}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 1,
                          ),
                        ),
                        Text(
                          '${getSplitDataInfo(widget.carona.data!, "m")}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            height: 1,
                          ),
                        ),
                        Text(
                          '${getSplitDataInfo(widget.carona.data!, "a")}',
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
                          '${widget.carona.origem ?? widget.carona.origem}',
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
                          '${widget.carona.destino ?? widget.carona.destinoCompleto}',
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
                            text: '${widget.carona.horaInico}',
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
                                    '${widget.carona.duracao}',
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
                            text: '${widget.carona.horaFim}',
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
                      formatFullName('${widget.carona.motoristanome}'),
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        '${widget.carona.valor}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Passageiro'),
                          Row(
                            children: [
                              const Icon(Icons.person_pin),
                              Text(
                                formatFullName(widget.carona.passageironome ?? 'Nenhum passageiro reservado'),
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.historico && widget.carona.passageirouid != null
                    ? FloatingActionButton(
                        heroTag: "whatsapp",
                        backgroundColor: Colors.green.shade800,
                        onPressed: () {
                          launchWhatsApp(widget.carona.passageirouid == sharedPref.getUserCurrent().uid
                              ? '${widget.carona.motoristatelefone}'
                              : '${widget.carona.passageirotelefone}');
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
                if (widget.carona.passageirouid == null &&
                    widget.carona.motoristauid != sharedPref.getUserCurrent().uid)
                  FloatingActionButton.extended(
                    heroTag: "reservarcarona",
                    backgroundColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        widget.carona.passageirouid = sharedPref.getUserCurrent().uid;
                        widget.carona.passageironome = sharedPref.getUserCurrent().nome;
                        widget.carona.passageiroemail = sharedPref.getUserCurrent().email;
                        widget.carona.passageirotelefone = sharedPref.getUserCurrent().telefone;
                        widget.carona.status = 'R';
                        CaronaHandler().updateCarona(widget.carona);
                      });
                    },
                    label: const Text(
                      'Reservar Carona',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (widget.carona.passageirouid == sharedPref.getUserCurrent().uid)
                  FloatingActionButton.extended(
                    heroTag: "cancelarcarona",
                    backgroundColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        widget.carona.passageirouid = null;
                        widget.carona.passageironome = null;
                        widget.carona.passageiroemail = null;
                        widget.carona.passageirotelefone = null;
                        widget.carona.status = 'A';
                        CaronaHandler().updateCarona(widget.carona);
                      });
                    },
                    label: const Text(
                      'Cancelar Carona',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (widget.carona.motoristauid == sharedPref.getUserCurrent().uid)
                  FloatingActionButton.extended(
                    heroTag: "encerrarcarona",
                    backgroundColor: const Color.fromARGB(255, 168, 47, 38),
                    onPressed: () {
                      setState(() {
                        widget.carona.status = 'F';
                        CaronaHandler().updateCarona(widget.carona);
                      });
                    },
                    label: const Text(
                      'Encerrar Carona',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (widget.carona.passageirouid != sharedPref.getUserCurrent().uid &&
                    widget.carona.passageirouid != null)
                  Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  launchWhatsApp(String numberPhone) async {
    String msg =
        "Olá ${formatFirstName(widget.carona.motoristanome)}! \n Vim atráves do aplicativo VIPTrack, tenho interesse na carona do dia ${widget.carona.data} \n ${widget.carona.origem} para ${widget.carona.destino} \n Com o valor de ${widget.carona.valor}.";

    if (numberPhone != null) {
      final link = WhatsAppUnilink(
        phoneNumber: '+55 $numberPhone',
        text: msg,
      );
      await launch('$link');
    }
  }
}
