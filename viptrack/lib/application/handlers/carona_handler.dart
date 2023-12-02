import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:viptrack/application/database/db_firestore.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/carona.dart';
import 'package:viptrack/domain/models/user.dart';

class CaronaHandler {
  final user = FirebaseAuth.instance.currentUser;
  final db = DbFirestore.get();
  final SharedPref sharedPref = SharedPref();

  Future<bool> saveCarona(Carona carona) async {
    String uid = const Uuid().v4();
    try {
      await db.collection('caronas/').doc(uid).set({
        'uid': uid,
        'origem': carona.origem,
        'origemCompleto': carona.origemCompleto,
        'destino': carona.destino,
        'destinoCompleto': carona.destinoCompleto,
        'valor': carona.valor ?? 'R\$ 24,99',
        'data': carona.data,
        'horaInico': carona.horaInico,
        'horaFim': carona.horaFim,
        'duracao': carona.duracao,
        'duracaoInt': carona.duracaoInt,
        'motoristanome': carona.motoristanome,
        'motoristatelefone': carona.motoristatelefone,
        'motoristaemail': carona.motoristaemail,
        'motoristauid': carona.motoristauid,
        'passageirouid': carona.passageirouid,
        'passageironome': carona.passageironome,
        'passageirotelefone': carona.passageirotelefone,
        'passageiroemail': carona.passageiroemail,
        'status': 'A',
        'distancia': carona.distancia,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  updateCarona(Carona carona) async {
    await db.collection('caronas/').doc(carona.uid).update({
      'uid': carona.uid,
      'origem': carona.origem,
      'origemCompleto': carona.origemCompleto,
      'destino': carona.destino,
      'destinoCompleto': carona.destinoCompleto,
      'valor': carona.valor,
      'data': carona.data,
      'horaInico': carona.horaInico,
      'horaFim': carona.horaFim,
      'duracao': carona.duracao,
      'duracaoInt': carona.duracaoInt,
      'motoristanome': carona.motoristanome,
      'motoristatelefone': carona.motoristatelefone,
      'motoristaemail': carona.motoristaemail,
      'motoristauid': carona.motoristauid,
      'passageirouid': carona.passageirouid,
      'passageironome': carona.passageironome,
      'passageirotelefone': carona.passageirotelefone,
      'passageiroemail': carona.passageiroemail,
      'status': carona.status,
      'distancia': carona.distancia,
    });
  }

  Future<List<Carona>> getAllCaronas() async {
    final querySnapshot = await db.collection('caronas/').where('status', isEqualTo: 'A').get();
    List<Carona> caronaList = [];
    querySnapshot.docs.forEach((doc) {
      caronaList.add(Carona.fromJson(doc.data()));
    });
    return caronaList;
  }

  Future<List<Carona>> getMotoCaronas() async {
    String? uidUser = sharedPref.getUserCurrent().uid;
    final querySnapshot = await db.collection('caronas/').where('motoristauid', isEqualTo: uidUser).get();
    List<Carona> caronaList = [];
    querySnapshot.docs.forEach((doc) {
      caronaList.add(Carona.fromJson(doc.data()));
    });
    return caronaList;
  }

  Future<List<Carona>> getCaronasCarona() async {
    String? uidUser = sharedPref.getUserCurrent().uid;
    final querySnapshot = await db.collection('caronas/').where('passageirouid', isEqualTo: uidUser).get();
    List<Carona> caronaList = [];
    querySnapshot.docs.forEach((doc) {
      caronaList.add(Carona.fromJson(doc.data()));
    });
    return caronaList;
  }
}
