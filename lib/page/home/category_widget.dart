import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../res/constants.dart';
import '../../res/gobalcolor.dart';
import '../../res/utils.dart';
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
                padding: EdgeInsets.only(left: mq.width * .022),
                child: InkWell(
                  onTap: () {
                    Provider.of<CategoryProvider>(context, listen: false)
                      ..setIndex(index: index)
                      ..setCategory(category: allCategoryList[index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * .044,
                        vertical: mq.height * .015),
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
