import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/newsModel.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.newsModel});
  final Articles newsModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Image.network(
              newsModel.urlToImage ?? '',
              height: 232.h,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  newsModel.author ?? '',
                  style: TextStyle(color: Colors.grey),
                )),
            Text(newsModel.title ?? ''),
            if (newsModel.publishedAt != null)
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    (timeago
                        .format(DateTime.parse(newsModel.publishedAt ?? ''))),
                    style: TextStyle(color: Colors.grey),
                  ))
          ],
        ),
      ),
    );
  }
}
