import 'package:flutter/material.dart';

import 'package:flutter_course_1/dummy_data.dart';
import 'package:flutter_course_1/widget/category_item_list.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return CategoryItemList(DUMMY_CATEGORIES[index]);
      },
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ), // this manage the structuring of grid
      itemCount: DUMMY_CATEGORIES.length,
    );
  }
}
