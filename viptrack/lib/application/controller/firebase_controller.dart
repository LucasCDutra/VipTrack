import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:viptrack/application/database/db_firestore.dart';

class FirebaseController {
  late FirebaseFirestore db;
  late FirebaseAuth auth;

  FirebaseController({required this.auth}) {
    //_startRepository
  }
}
