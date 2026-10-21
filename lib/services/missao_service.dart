import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MissaoService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _colecao =>
      firestore.collection('usuarios').doc(_uid).collection('missoes');

  Future<void> concluirMissao(String titulo) async {
    await _colecao.add({
      'titulo': titulo.trim(),
      'concluidaEm': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listarMissoes() =>
      _colecao.orderBy('concluidaEm', descending: true).snapshots();
}
