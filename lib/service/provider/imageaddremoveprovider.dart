import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/res/constants.dart';

class ImageAddRemoveProvider with ChangeNotifier {
  // Cateogry
  String _categoryName = allCategoryList.skip(0).first;

  // get Category Item
  String get getCategory => _categoryName;

  // set Category
  setCategory({required String cateory}) {
    _categoryName = cateory;
    notifyListeners();
  }

  // Unit
  String _unit = unitList.first;

  // getUnit
  String get getUnit => _unit;
  // set Unit
  setUnit({required String unitValue}) {
    _unit = unitValue;
    notifyListeners();
  }

  //Single Image Select
  XFile? _imageXfile;

  XFile? get singleImageXFile => _imageXfile;

  void setSingleImageXFile(
      {required XFile? singleImageXFile, bool isChange = false}) {
    _imageXfile = singleImageXFile;
    _isChangeProfilePicture = isChange;
    notifyListeners();
  }

  bool _isChangeProfilePicture = false;
  bool get isChangeProfilePicture => _isChangeProfilePicture;

  //Image urls
  String _singleImageUrl = "";
  String get singleImageUrl => _singleImageUrl;
  void setSingleImageUrl({required String singleImageUrl}) {
    _singleImageUrl = singleImageUrl;
    notifyListeners();
  }
}
