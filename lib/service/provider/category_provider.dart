import 'package:flutter/material.dart';

import '../../const/const.dart';

class CategoryProvider with ChangeNotifier {
  String _category = allCategoryList.first;

  String get getCategory => _category;

  setCategory({required String category}) {
    _category = category;
    notifyListeners();
  }

  int _index = 0;

  int get index => _index;

  setIndex({required int index}) {
    _index = index;
    notifyListeners();
  }
}
