import 'package:get/get.dart';

import '../res/app_constant.dart';

class CategoryController extends GetxController {
  final _category = AppConstant.cateogryTypes.first.obs;

  String get getCategory => _category.value;

  void setCategory({required String category}) {
    _category.value = category;
  }
}
