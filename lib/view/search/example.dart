
/*
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = Get.find<SearchControllers>();
  @override
  void initState() {
    // searchController.initializeDefaultValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppString.searchProduct,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              const SearchBarWidget(),
              _buildProductGrid(),
            ],
          ),
        ),
      ),
    );
  }

/*
    Expanded _buildProductGrid() {
      return Expanded(
        child: Obx(
          () => StreamBuilder(
            stream: searchController.productSnapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingListProductWidget();
              }
              if (snapshot.hasData) {
                searchController.allProductList.value = snapshot.data!.docs
                    .map((e) => ProductModel.fromMap(e.data()))
                    .toList();

                return const SearchProductGridWidget();
              }

              return const LoadingListProductWidget();
            },
          ),
        ),
      );
    }
 
 */
  Expanded _buildProductGrid() {
    return Expanded(
      child: Obx(
        () => StreamBuilder(
          stream: searchController.productSnapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingListProductWidget();
            }
            if (snapshot.hasData) {
              searchController.allProductList.value = snapshot.data!.docs
                  .map((e) => ProductModel.fromMap(e.data()))
                  .toList();

              // Let the Obx rebuild the filtered/searched UI
              return const SearchProductGridWidget();
            }

            return const LoadingListProductWidget();
          },
        ),
      ),
    );
  }
}

*/



/*
class SearchProductGridWidget extends StatelessWidget {
  const SearchProductGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final productList = _getProductList();

      if (productList.isEmpty) {
        return EmptyWidget(
          image: ImagesAsset.error,
          title: AppString.noDataAvailable,
        );
      }

      return GridView.builder(
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .78,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          return ProductWidget(
            productModel: productList[index],
          );
        },
      );
    });
  }

  List<ProductModel> _getProductList() {
    var searchController = Get.find<SearchControllers>();
    if (searchController.isFilterEnabled.value &&
        searchController.searchTextTEC.text.isEmpty) {
      return searchController.filterProductList;
    }
    if (searchController.isSearchEnabled.value &&
        searchController.searchTextTEC.text.isNotEmpty) {
      return searchController.searchProductList;
    }

    return searchController.allProductList;
  }
}
*/





/*
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchControllers>();

    return SizedBox(
      height: 0.1.sh,
      width: 1.sw,
      child: Row(
        children: [
          Flexible(
              flex: 4,
              child: TextFormFieldWidget(
                style: AppsTextStyle.mediumNormalText
                    .copyWith(color: Utils.getColor),
                isUdateDecoration: true,
                decoration: AppsFunction.inputDecoration(
                    hint: AppString.searchProductHere),
                controller: searchController.searchTextTEC,
                onChanged: (text) {
                  searchController.updateProductList(text);
                  // setState(() {});
                },
              )),
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.dialog(const FilterDialogWidget());
              },
              icon: Icon(
                FontAwesomeIcons.sliders,
                color: AppColors.accentGreen,
              ))
        ],
      ),
    );
  }
}

*/



// Bangladesh
/*
class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchControllers>();
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
                  .copyWith(color: AppColors.accentGreen),
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
            list: allCategoryList,
            value: searchController.selectedCategory.value,
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
        Text(AppString.productPrice, style: AppsTextStyle.mediumBoldText),
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
*/





/*
class SearchControllers extends GetxController {
  // Dependencies
  final productController = Get.find<ProductController>();

  // Text editing controllers for filters and search input
  final minPriceTEC = TextEditingController();
  final maxPriceTEC = TextEditingController();
  final searchTextTEC = TextEditingController();

  // Observables for category selection, product lists, and flags
  var selectedCategory = allCategoryList.first.obs;
  var category = allCategoryList.first;
  var allProductList = <ProductModel>[].obs;
  var searchProductList = <ProductModel>[].obs;
  var filterProductList = <ProductModel>[].obs;
  var searchAndFilterList = <ProductModel>[].obs;

  var isSearchEnabled = false.obs;
  var isFilterEnabled = false.obs;

  void initializeDefaultValues() {
    searchTextTEC.text = "";
    setCategory(AppString.all);
    minPriceTEC.text = AppString.searchMinPrice;
    maxPriceTEC.text = AppString.searchMaxPrice;
    isFilterEnabled.value = false;
    filterProductList.value = [];
    searchProductList.value = [];
  }

  // Dispose text controllers to prevent memory leaks
  @override
  void onClose() {
    minPriceTEC.dispose();
    maxPriceTEC.dispose();
    searchTextTEC.dispose();
    super.onClose();
  }

  // Update selected category
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  // Update search product list based on search text
  void updateProductList(String text) {
    searchProductList.clear();

    var searchText = text.toLowerCase();

    final productListToSearch =
        isFilterEnabled.value ? filterProductList : allProductList;

    searchProductList.addAll(productListToSearch.where((productModel) =>
        productModel.productname!.toLowerCase().contains(searchText)));

    isSearchEnabled.value = true;
  }

  void applyPriceFilter() {
    filterProductList.clear();

    double minPrice = double.parse(minPriceTEC.text);
    double maxPrice = double.parse(maxPriceTEC.text);

    filterProductList.addAll(allProductList.where((productModel) {
      final double effectivePrice = AppsFunction.productPrice(
        productModel.productprice!,
        productModel.discount!.toDouble(),
      );
      return effectivePrice >= minPrice && effectivePrice <= maxPrice;
    }));

    isFilterEnabled.value = true;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots() {
    try {
      return productController.repository
          .fetchCategoryProducts(category: selectedCategory.value);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: AppIcons.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }
}

*/