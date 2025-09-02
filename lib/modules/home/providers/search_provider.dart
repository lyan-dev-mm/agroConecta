import 'package:flutter/material.dart';
import 'package:agroconecta/models/post_model.dart';
import 'package:agroconecta/services/firestore_service.dart';
import 'package:flutter/widgets.dart'; //  ScrollDirection// ✅ necesario para ScrollDirection

class SearchProvider extends ChangeNotifier {
  final FirestoreService _firestore = FirestoreService();
  List<PostModel> _resultados = [];
  List<PostModel> get resultados => _resultados;
  String _query = '';
  String get query => _query;

  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }

  Future<void> buscarPorHashtag(String hashtag) async {
    final querySnapshot = await _firestore.db
        .collection('posts')
        .where('hashtags', arrayContains: hashtag.toLowerCase())
        .get();

    _resultados = querySnapshot.docs
        .map((doc) => PostModel.fromDoc(doc))
        .toList();

    notifyListeners();
  }

  void limpiarResultados() {
    _resultados = [];
    notifyListeners();
  }
}
