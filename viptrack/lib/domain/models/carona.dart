// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:viptrack/application/controller/firebase_controller.dart';
import 'package:viptrack/application/database/db_firestore.dart';

class Carona {
  String? origem;
  String? origemCompleto;
  String? destino;
  String? destinoCompleto;
  String? valor;
  String? data;
  String? horaInico;
  String? horaFim;
  String? duracao;
  int? duracaoInt;
  String? motoristanome;
  String? motoristatelefone;
  String? motoristaemail;
  String? passageironome;
  String? passageirotelefone;
  String? passageiroemail;
  bool? finalizada;
  String? distancia;

  Carona({
    this.origem,
    this.origemCompleto,
    this.destino,
    this.destinoCompleto,
    this.valor,
    this.data,
    this.horaInico,
    this.horaFim,
    this.duracao,
    this.motoristanome,
    this.motoristatelefone,
    this.motoristaemail,
    this.passageironome,
    this.passageirotelefone,
    this.passageiroemail,
    this.finalizada,
    this.distancia,
    this.duracaoInt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['origem'] = origem;
    data['origemCompleto'] = origemCompleto;
    data['detino'] = destino;
    data['destinoCompleto'] = destinoCompleto;
    data['valor'] = valor;
    data['data'] = data;
    data['horaInico'] = horaInico;
    data['horaFim'] = horaFim;
    data['duracao'] = duracao;
    data['motoristanome'] = motoristanome;
    data['motoristatelefone'] = motoristatelefone;
    data['motoristaemail'] = motoristaemail;
    data['passageironome'] = passageironome;
    data['passageirotelefone'] = passageirotelefone;
    data['passageiroemail'] = passageiroemail;
    data['finalizada'] = finalizada;
    data['distancia'] = distancia;
    data['duracaoInt'] = duracaoInt;
    return data;
  }

  Carona.fromJson(Map<String, dynamic> jsonData) {
    origem = jsonData['origem'];
    origemCompleto = jsonData['origemCompleto'];
    destino = jsonData['destino'];
    destinoCompleto = jsonData['destinoCompleto'];
    valor = jsonData['valor'];
    horaInico = jsonData['horaInico'];
    data = jsonData['data'];
    horaFim = jsonData['horaFim'];
    duracao = jsonData['duracao'];
    motoristanome = jsonData['motoristanome'];
    motoristatelefone = jsonData['motoristatelefone'];
    motoristaemail = jsonData['motoristaemail'];
    passageironome = jsonData['motoristanome'];
    passageirotelefone = jsonData['passageirotelefone'];
    passageiroemail = jsonData['passageiroemail'];
    finalizada = jsonData['finalizada'];
    distancia = jsonData['distancia'];
    duracaoInt = jsonData['duracaoInt'];
  }
}
