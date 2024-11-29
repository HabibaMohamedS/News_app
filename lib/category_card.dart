import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/category_model.dart';

class Category_Card extends StatelessWidget {
  const Category_Card({super.key, required this.index, required this.model});
  final int index;
  final CategoryModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: model.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft:
                  index.isEven ? Radius.circular(25) : Radius.circular(0),
              bottomRight:
                  index.isOdd ? Radius.circular(25) : Radius.circular(0),
            )),
        child: Column(children: [
          Image.asset(
            model.image,
            width: 100.w,
            fit: BoxFit.contain,
          ),
          Text(model.title)
        ]),
      ),
    );
  }
}
