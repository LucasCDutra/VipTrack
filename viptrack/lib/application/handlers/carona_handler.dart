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
    try {
      await db.collection('caronas/').doc(const Uuid().v4()).set({
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
        'passageironome': carona.passageironome,
        'passageirotelefone': carona.passageirotelefone,
        'passageiroemail': carona.passageiroemail,
        'finalizada': false,
        'distancia': carona.distancia,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Carona>> getAllCaronas() async {
    final querySnapshot = await db.collection('caronas/').where('finalizada', isEqualTo: false).get();
    List<Carona> caronaList = [];
    querySnapshot.docs.forEach((doc) {
      caronaList.add(Carona.fromJson(doc.data()));
    });
    return caronaList;
  }
}
