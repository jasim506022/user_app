import 'package:get/get.dart';

import '../../res/constants.dart';

class CategoryController extends GetxController {
  // Curent Category
  final _category = allCategoryList.first.obs;

  String get getCategory => _category.value;

  setCategory({required String category}) {
    _category.value = category;
  }
}
