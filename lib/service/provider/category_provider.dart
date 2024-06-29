import 'package:flutter/material.dart';

import '../../res/constants.dart';

class CategoryProvider with ChangeNotifier {
  // Curent Category
  String _category = allCategoryList.first;

  String get getCategory => _category;

  setCategory({required String category}) {
    _category = category;
    notifyListeners();
  }

// Current Index
  int _index = 0;

  int get index => _index;

  setIndex({required int index}) {
    _index = index;
    notifyListeners();
  }
}
