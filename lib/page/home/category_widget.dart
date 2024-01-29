import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/utils.dart';
import '../../service/provider/category_provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return SizedBox(
      height: mq.height * .058,
      width: mq.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategoryList.length,
        itemBuilder: (context, index) {
          return Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Provider.of<CategoryProvider>(context, listen: false)
                      ..setIndex(index: index)
                      ..setCategory(category: allCategoryList[index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                        color: categoryProvider.index == index
                            ? utils.categorySelectBackground
                            : utils.categoryUnselectBackground,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      allCategoryList[index],
                      style: GoogleFonts.poppins(
                          color: categoryProvider.index == index
                              ? white
                              : utils.categoryUnSelectTextColor,
                          fontSize: 12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
