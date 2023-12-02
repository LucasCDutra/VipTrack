// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:viptrack/application/controller/firebase_controller.dart';
import 'package:viptrack/application/database/db_firestore.dart';

class Carona {
  String? uid;
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
  String? motoristauid;
  String? motoristatelefone;
  String? motoristaemail;
  String? passageirouid;
  String? passageironome;
  String? passageirotelefone;
  String? passageiroemail;
  String? status;
  String? distancia;

  Carona({
    this.uid,
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
    this.motoristauid,
    this.motoristatelefone,
    this.motoristaemail,
    this.passageironome,
    this.passageirouid,
    this.passageirotelefone,
    this.passageiroemail,
    this.status,
    this.distancia,
    this.duracaoInt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
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
    data['motoristauid'] = motoristauid;
    data['motoristatelefone'] = motoristatelefone;
    data['motoristaemail'] = motoristaemail;
    data['passageironome'] = passageironome;
    data['passageirouid'] = passageirouid;
    data['passageirotelefone'] = passageirotelefone;
    data['passageiroemail'] = passageiroemail;
    data['status'] = status;
    data['distancia'] = distancia;
    data['duracaoInt'] = duracaoInt;
    return data;
  }

  Carona.fromJson(Map<String, dynamic> jsonData) {
    uid = jsonData['uid'];
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
    motoristauid = jsonData['motoristauid'];
    motoristatelefone = jsonData['motoristatelefone'];
    motoristaemail = jsonData['motoristaemail'];
    passageironome = jsonData['passageironome'];
    passageirouid = jsonData['passageirouid'];
    passageirotelefone = jsonData['passageirotelefone'];
    passageiroemail = jsonData['passageiroemail'];
    status = jsonData['status'];
    distancia = jsonData['distancia'];
    duracaoInt = jsonData['duracaoInt'];
  }
}
