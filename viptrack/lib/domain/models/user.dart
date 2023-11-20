import 'package:firebase_auth/firebase_auth.dart';
import 'package:viptrack/application/controller/firebase_controller.dart';
import 'package:viptrack/application/database/db_firestore.dart';

class UserApp extends FirebaseController {
  String? uid;
  String? email;
  String? nome;
  String? telefone;

  UserApp({
    this.uid,
    this.email,
    this.nome,
    this.telefone,
    required super.auth,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['telefone'] = telefone;
    data['nome'] = nome;
    data['email'] = email;
    return data;
  }

  save() async {
    db = DbFirestore.get();
    await db
        .collection('usuarios/')
        .doc(auth.currentUser?.email)
        .set({'uid': uid, 'email': email, 'nome': nome, 'telefone': telefone});

    print(' === SALVO NO FIRE BASE === ');
  }

  readCurrrent() async {
    db = DbFirestore.get();
    final snapshot = await db.collection('usuarios').doc(auth.currentUser?.email).get();
    telefone = snapshot.data()?['telefone'];
    nome = snapshot.data()?['nome'];
    email = snapshot.data()?['email'];
    uid = snapshot.data()?['uid'];
    auth = FirebaseAuth.instance;
  }
}
