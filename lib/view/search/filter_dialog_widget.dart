import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/widget/text_form_field_widget.dart';

import '../../controller/search_controller.dart';
import '../../res/app_colors.dart';
import '../../res/app_function.dart';

import '../../res/apps_text_style.dart';
import '../product/product_page.dart';
import '../product/widget/drop_down_category_widget.dart';

class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = Get.put(SearchControllers());
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      elevation: 8, // You can adjust thi
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: _contentData(searchController, context),
    );
  }

  ElevatedButton _buildDialogButton(String title, void Function()? onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenColor,
          padding: const EdgeInsets.all(5)),
      onPressed: onPressed,
      child: Text(title,
          style: GoogleFonts.roboto(
              color: AppColors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500)),
    );
  }

  _contentData(SearchControllers searchController, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Filter Search",
              textAlign: TextAlign.center,
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: AppColors.deepGreen, fontSize: 16.sp),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          _productPriceSearch(searchController),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Product Category',
            style: AppsTextStyle.largeText.copyWith(fontSize: 15),
          ),
          SizedBox(
            height: 10.h,
          ),
          DropdownCategoryWidget(
            isSearch: true,
            category: searchController.selectSearchCategory.value,
            onChanged: (category) {
              searchController.setCategory(category!);
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          _dialogButtonWidget(searchController, context)
        ],
      ),
    );
  }

  Row _dialogButtonWidget(
      SearchControllers searchController, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              searchController.setFilter(false);
              searchController
                ..setCategory("All")
                ..maxPriceTEC.text = "10000.0"
                ..minPriceTEC.text = "0.0";
              Get.back();
            },
            child: Text(
              "Reset",
              style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
            )),
        Row(
          children: [
            _buildDialogButton(
              'Close',
              () {
                Get.back();
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            _buildDialogButton(
              'Save',
              () {
                FocusScope.of(context).unfocus();
                searchController.searchTextTEC.text = "";
                searchController.filterListAddProduct();

                Get.back();
              },
            )
          ],
        )
      ],
    );
  }

  Column _productPriceSearch(SearchControllers searchController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Price',
          style: AppsTextStyle.largeText.copyWith(fontSize: 15),
        ),
        Row(
          children: [
            _buildPriceTextField(
                controller: searchController.minPriceTEC, hintText: "Minium"),
            SizedBox(
              width: 15.w,
            ),
            _buildPriceTextField(
                controller: searchController.maxPriceTEC, hintText: "Maximum"),
          ],
        ),
      ],
    );
  }

  Expanded _buildPriceTextField(
      {required TextEditingController controller, required String hintText}) {
    return Expanded(
        child: TextFormFieldWidget(
      controller: controller,
      isUdateDecoration: true,
      decoration: AppsFunction.inputDecoration(
        hint: hintText,
      ),
    ));
  }
}
