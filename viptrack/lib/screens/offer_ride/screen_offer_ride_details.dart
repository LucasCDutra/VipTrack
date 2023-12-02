import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:viptrack/application/helpers/commons.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/domain/models/user.dart';
import 'package:viptrack/widgets/oferecer_carona.dart';

class OfferRideDetails extends StatefulWidget {
  final Carona carona;
  const OfferRideDetails({super.key, required this.carona});

  @override
  State<OfferRideDetails> createState() => _OfferRideDetailsState();
}

class _OfferRideDetailsState extends State<OfferRideDetails> {
  DateTime dateTime = DateTime.now();
  TextEditingController textControllerValor = TextEditingController();
  final SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    UserApp user = sharedPref.getUserCurrent();
    widget.carona.motoristanome = user.nome;
    widget.carona.motoristaemail = user.email;
    widget.carona.motoristatelefone = user.telefone;
    widget.carona.motoristauid = user.uid;

    widget.carona.data = UtilData.obterDataDDMMAAAA(dateTime);
    widget.carona.horaInico = UtilData.obterHoraHHMM(dateTime);
    widget.carona.horaFim = getDropOffTime(dateTime, widget.carona.duracaoInt!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<DateTime?> pickDate() => showDatePicker(
          context: context,
          initialDate: dateTime,
          firstDate: DateTime.now().subtract(const Duration(hours: 10)),
          lastDate: DateTime(2100),
        );

    Future<TimeOfDay?> pickTime() => showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        );

    Future pickDateTime() async {
      DateTime? date = await pickDate();
      if (date == null) return;

      TimeOfDay? time = await pickTime();
      if (time == null) return;

      final dateTimeNew = DateTime(date.year, date.month, date.day, time.hour, time.minute);

      setState(() {
        dateTime = dateTimeNew;
        widget.carona.data = UtilData.obterDataDDMMAAAA(dateTime);
        widget.carona.horaInico = UtilData.obterHoraHHMM(dateTime);
        widget.carona.horaFim = getDropOffTime(dateTime, widget.carona.duracaoInt!);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${widget.carona.origemCompleto} ➡ ${widget.carona.destinoCompleto}',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: size.width * 0.9,
                height: 80,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 104, 104, 104).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(1, 3), // changes position of shadow
                      ),
                    ],
                    color: const Color.fromARGB(255, 238, 238, 238),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          String.fromCharCode(CupertinoIcons.arrowshape_turn_up_right_fill.codePoint),
                          style: TextStyle(
                            inherit: false,
                            color: Colors.red.shade800,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: CupertinoIcons.arrowshape_turn_up_right_fill.fontFamily,
                            package: CupertinoIcons.arrowshape_turn_up_right_fill.fontPackage,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${widget.carona.origemCompleto}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${widget.carona.destinoCompleto}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        Text(
                          String.fromCharCode(CupertinoIcons.arrowshape_turn_up_left_fill.codePoint),
                          style: TextStyle(
                            inherit: false,
                            color: Colors.green.shade800,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: CupertinoIcons.arrowshape_turn_up_left_fill.fontFamily,
                            package: CupertinoIcons.arrowshape_turn_up_left_fill.fontPackage,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: size.width * 0.9,
                height: size.height * 0.7,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 104, 104, 104).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(1, 3), // changes position of shadow
                      ),
                    ],
                    color: const Color.fromARGB(255, 238, 238, 238),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(4, 10, 4, 0),
                              child: Text(
                                'Valor da Carona',
                              ),
                            ),
                            TextField(
                              controller: textControllerValor,
                              keyboardType: TextInputType.number,
                              onEditingComplete: () {
                                // save function
                                print('-----> ${textControllerValor.text}');
                                setState(() {
                                  widget.carona.valor = textControllerValor.text;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CentavosInputFormatter(moeda: true)
                              ],
                              textAlignVertical: TextAlignVertical.bottom,
                              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintText: 'R\$ 24,99',
                                hintStyle:
                                    const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.attach_money_rounded,
                                  color: Colors.green.shade700,
                                  size: 30,
                                ),
                                constraints: const BoxConstraints(maxHeight: 45),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text('Defina o Início da Viagem'),
                      ),
                      SizedBox(
                        width: 300,
                        height: 80,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              backgroundColor: const MaterialStatePropertyAll(Colors.black)),
                          onPressed: pickDateTime,
                          child: Text(
                            '${UtilData.obterDataDDMMAAAA(dateTime)}  ${UtilData.obterHoraHHMM(dateTime)}',
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(
                          Icons.directions_car_filled,
                          size: 35,
                        ), //const Image(image: AssetImage('assets/image/sport-car.png'), height: 50, width: 50),
                        title: RichText(
                          text: TextSpan(
                            text: 'Distância: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                  text: '${widget.carona.distancia} km',
                                  style: const TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        //Text('Distância', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: RichText(
                          text: TextSpan(
                            text: 'Duração: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(text: widget.carona.duracao, style: const TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: OferecerCaronaButton(
        carona: widget.carona,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
