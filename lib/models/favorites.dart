import 'package:flutter/material.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class Favorites extends ChangeNotifier {
  final List<int> _favoriteitems = [];

  List<int> get items => _favoriteitems;

  void add(int itemNo) {
    _favoriteitems.add(itemNo);
    notifyListeners();
  }

  void remove(int itemNo) {
    _favoriteitems.remove(itemNo);
    notifyListeners();
  }
}
