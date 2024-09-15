import 'package:get/get.dart';

import '../../res/constants.dart';

class CategoryController extends GetxController {
  final _category = allCategoryList.first.obs;

  String get getCategory => _category.value;

  void setCategory({required String category}) {
    _category.value = category;
  }
}
