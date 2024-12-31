import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';

import 'package:user_app/widget/text_form_field_widget.dart';

import '../../../controller/search_controller.dart';
import '../../../res/app_colors.dart';

import '../../../res/apps_text_style.dart';
import '../../../widget/custom_round_action_button.dart';
import '../../product/widget/drop_down_category_widget.dart';

class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchControllers>();
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).cardColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      content: _contentData(searchController, context),
    );
  }

  _contentData(SearchControllers searchController, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15.r)),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              AppString.filterSearch,
              textAlign: TextAlign.center,
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: AppColors.deepGreenAccent),
            ),
          ),
          AppsFunction.verticleSpace(10),
          _productPriceSearch(searchController),
          AppsFunction.verticleSpace(10),
          Text(
            AppString.pCategory,
            style: AppsTextStyle.largeText.copyWith(fontSize: 15),
          ),
          AppsFunction.verticleSpace(10),
          DropdownCategoryWidget(
            isSearch: true,
            category: searchController.selectedCategory.value,
            onChanged: (category) {
              searchController.setCategory(category!);
            },
          ),
          AppsFunction.verticleSpace(10),
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
              searchController.isFilterEnabled.value = false;
              searchController
                ..setCategory("All")
                ..maxPriceTEC.text = AppString.searchMaxPrice
                ..minPriceTEC.text = AppString.searchMinPrice;
              Get.back();
            },
            child: Text(
              AppString.reset,
              style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
            )),
        Row(
          children: [
            CustomRoundActionButton(
              horizontal: 10.w,
              title: AppString.close,
              onTap: () => Get.back(),
            ),
            AppsFunction.horizontalSpace(10),
            CustomRoundActionButton(
              title: AppString.save,
              horizontal: 10.w,
              onTap: () {
                FocusScope.of(context).unfocus();
                searchController.searchTextTEC.text = "";
                searchController.applyPriceFilter();
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
          AppString.productPrice,
          style: AppsTextStyle.largeText.copyWith(fontSize: 15),
        ),
        Row(
          children: [
            Expanded(
                child: TextFormFieldWidget(
                    hintText: AppString.minimumHintText,
                    controller: searchController.minPriceTEC)),
            AppsFunction.horizontalSpace(15),
            Expanded(
              child: TextFormFieldWidget(
                  controller: searchController.maxPriceTEC,
                  hintText: AppString.maxiMumHintText),
            ),
          ],
        ),
      ],
    );
  }
}
