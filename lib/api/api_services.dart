import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_consts.dart';
import 'package:news_app/models/SourceModel.dart';
import 'package:news_app/models/newsModel.dart';

class ApiServices {
  static Future<SourceModel> getSources(String categoryID) async {
    var url = Uri.https(ApiConsts.baseURL, ApiConsts.sourcesEndPoin,
        {'apiKey': ApiConsts.apiKey, 'category': categoryID});
    var responce = await http.get(url);
    String body = responce.body;

    var json = jsonDecode(body);
    return SourceModel.fromJson(json);
  }

  static Future<NewsModel> getNews(String sourceID) async {
    var url = Uri.https(ApiConsts.baseURL, ApiConsts.newsEndPoint,
        {'apiKey': ApiConsts.apiKey, 'sources': sourceID});
    var responce = await http.get(url);
    String body = responce.body;

    var json = jsonDecode(body);
    return NewsModel.fromJson(json);
  }
}
