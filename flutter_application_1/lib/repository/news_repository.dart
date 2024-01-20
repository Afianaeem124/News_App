import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/model/categories_news_model.dart';
import 'package:flutter_application_1/model/news_channel_model.dart';
import 'package:http/http.dart';

class NewsRepository {
  Future<NewsChannelHeadLinesModel> fetchNewsHeadlinesApi(String channelname) async {
    final respose = await get(Uri.parse('https://newsapi.org/v2/top-headlines?sources=$channelname&apiKey=436677f67002475aab94d709d225211c'));
    // if (kDebugMode) {
    //   print(respose.body);
    // }

    if (respose.statusCode == 200) {
      final body = jsonDecode(respose.body);

      return NewsChannelHeadLinesModel.fromJson(body);
    } else {
      throw Exception('error');
    }
  }

  Future<CategoreiesNewsModel> fetchCategoryNewsApi(String categoryname) async {
    final respose = await get(Uri.parse('https://newsapi.org/v2/everything?q=${categoryname}&apiKey=436677f67002475aab94d709d225211c'));
    if (kDebugMode) {
      print(respose.body);
    }

    if (respose.statusCode == 200) {
      final body = jsonDecode(respose.body);

      return CategoreiesNewsModel.fromJson(body);
    } else {
      throw Exception('error');
    }
  }
}
