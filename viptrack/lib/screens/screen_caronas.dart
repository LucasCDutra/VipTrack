import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/screens/search_car/info_search_car.dart';
import 'package:viptrack/utils/formatters.dart';
import 'package:viptrack/application/handlers/carona_handler.dart';

class ScreenCaronas extends StatefulWidget {
  const ScreenCaronas({super.key});

  @override
  State<ScreenCaronas> createState() => _ScreenCaronasState();
}

class _ScreenCaronasState extends State<ScreenCaronas> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future<List<Carona>>? caronaListMot;
    Future<List<Carona>>? caronaListCarona;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Motorista',
                  icon: Icon(FontAwesomeIcons.userTie),
                ),
                Tab(
                  text: 'Carona',
                  icon: Icon(FontAwesomeIcons.handshakeAngle),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: FutureBuilder(
                    future: CaronaHandler().getMotoCaronas(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasError) {
                        if (!snapshot.hasData) {
                          return Shimmer.fromColors(
                              // ignore: sort_child_properties_last
                              child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      height: 120,
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
                                          border:
                                              Border.all(color: const Color.fromARGB(179, 158, 158, 158), width: 1.5)),
                                    );
                                  }),
                              baseColor: const Color.fromARGB(255, 228, 228, 228),
                              highlightColor: Color.fromARGB(255, 218, 216, 216));
                          //  return const Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Carona? cinfo = snapshot.data[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => InfoSearchCar(
                                          carona: cinfo,
                                          historico: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
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
                                        border:
                                            Border.all(color: const Color.fromARGB(179, 158, 158, 158), width: 1.5)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '${getSplitDataInfo(cinfo!.data!, "d")}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    height: 1,
                                                  ),
                                                ),
                                                Text(
                                                  '${getSplitDataInfo(cinfo.data!, "m")}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                    height: 1,
                                                  ),
                                                ),
                                                Text(
                                                  '${getSplitDataInfo(cinfo.data!, "a")}',
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
                                                  '${cinfo.origem ?? cinfo.origem}',
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
                                                  '${cinfo.destino ?? cinfo.destinoCompleto}',
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
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(text: '${cinfo.horaInico}'),
                                                      const WidgetSpan(
                                                        alignment: PlaceholderAlignment.middle,
                                                        child: Icon(Icons.arrow_right_rounded),
                                                        style:
                                                            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                                      ),
                                                      TextSpan(text: '${cinfo.horaFim}'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${cinfo.valor}',
                                              style:
                                                  TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatFirstName(cinfo.motoristanome),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                      return Container(
                        height: 30,
                        width: 200,
                      );
                    }),
              ),
            ),
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: FutureBuilder(
                    future: CaronaHandler().getCaronasCarona(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasError) {
                        if (!snapshot.hasData) {
                          return Shimmer.fromColors(
                              // ignore: sort_child_properties_last
                              child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      height: 120,
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
                                          border:
                                              Border.all(color: const Color.fromARGB(179, 158, 158, 158), width: 1.5)),
                                    );
                                  }),
                              baseColor: const Color.fromARGB(255, 228, 228, 228),
                              highlightColor: Color.fromARGB(255, 218, 216, 216));
                          //  return const Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Carona? cinfo = snapshot.data[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => InfoSearchCar(carona: cinfo, historico: true),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
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
                                        border:
                                            Border.all(color: const Color.fromARGB(179, 158, 158, 158), width: 1.5)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  '${getSplitDataInfo(cinfo!.data!, "d")}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    height: 1,
                                                  ),
                                                ),
                                                Text(
                                                  '${getSplitDataInfo(cinfo.data!, "m")}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                    height: 1,
                                                  ),
                                                ),
                                                Text(
                                                  '${getSplitDataInfo(cinfo.data!, "a")}',
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
                                                  '${cinfo.origem ?? cinfo.origem}',
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
                                                  '${cinfo.destino ?? cinfo.destinoCompleto}',
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
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(text: '${cinfo.horaInico}'),
                                                      const WidgetSpan(
                                                        alignment: PlaceholderAlignment.middle,
                                                        child: Icon(Icons.arrow_right_rounded),
                                                        style:
                                                            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                                      ),
                                                      TextSpan(text: '${cinfo.horaFim}'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${cinfo.valor}',
                                              style:
                                                  TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formatFirstName(cinfo.motoristanome),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                      return Container(
                        height: 30,
                        width: 200,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
