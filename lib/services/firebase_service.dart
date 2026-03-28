// lib/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/match.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String matchesCollection = 'matches';

  Future<void> saveMatch(MatchModel match) async {
    final doc = _db.collection(matchesCollection).doc();
    await doc.set(match.toMap());
  }

  Future<List<MatchModel>> getAllMatches() async {
    final snap =
        await _db
            .collection(matchesCollection)
            .orderBy('date', descending: true)
            .get();
    return snap.docs
        .map((d) => MatchModel.fromMap(d.data(), id: d.id))
        .toList();
  }

  Stream<List<MatchModel>> matchesStream() {
    return _db
        .collection(matchesCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs
                  .map((d) => MatchModel.fromMap(d.data(), id: d.id))
                  .toList(),
        );
  }

  Future<void> deleteMatch(String id) async {
    await _db.collection(matchesCollection).doc(id).delete();
  }
}
