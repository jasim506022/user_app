import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/search_controller.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constant.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../widget/custom_round_action_button.dart';
import '../../product/widget/drop_down_category_widget.dart';
import 'product_price_box_widget.dart';

class FilterDialogContentWidget extends StatelessWidget {
  const FilterDialogContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          AppsFunction.verticalSpacing(10),
          const ProductPriceBoxWidget(),
          AppsFunction.verticalSpacing(10),
          _buildCategoryDropdown(),
          AppsFunction.verticalSpacing(10),
          _buildActionButtons(
            context,
          ),
        ],
      ),
    );
  }

  /// Builds the title section for the dialog.
  Widget _buildTitle() {
    return Center(
      child: Text(
        AppString.filterSearch,
        style:
            AppsTextStyle.titleTextStyle.copyWith(color: AppColors.accentGreen),
      ),
    );
  }

  /// Builds the category dropdown section.
  Widget _buildCategoryDropdown() {
    final searchController = Get.find<ProductSearchController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.productCategory, style: AppsTextStyle.mediumBoldText),
        AppsFunction.verticalSpacing(10),
        DropdownCategoryWidget(
          value: searchController.selectedCategory.value,
          list: AppConstant.cateogryTypes,
          onChanged: (category) {
            if (category != null) {
              searchController.setCategory(category);
            }
          },
        ),
      ],
    );
  }

  /// Builds the action buttons section.
  Widget _buildActionButtons(BuildContext context) {
    final searchController = Get.find<ProductSearchController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: searchController.resetFilters,
          child: Text(
            AppString.reset,
            style: AppsTextStyle.largeBoldText.copyWith(color: AppColors.red),
          ),
        ),
        Row(
          children: [
            CustomRoundActionButton(
              horizontal: 10.w,
              title: AppString.close,
              onTap: () => Get.back(),
            ),
            AppsFunction.horizontalSpacing(10),
            CustomRoundActionButton(
              horizontal: 10.w,
              title: AppString.save,
              onTap: () {
                FocusScope.of(context).unfocus();
                searchController.applyFilters();
              },
            ),
          ],
        ),
      ],
    );
  }
}
