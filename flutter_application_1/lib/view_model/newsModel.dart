import 'package:flutter_application_1/model/categories_news_model.dart';
import 'package:flutter_application_1/model/news_channel_model.dart';
import 'package:flutter_application_1/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelHeadLinesModel> fetchNewsHeadlinesApi(String channelname) async {
    final response = await _repo.fetchNewsHeadlinesApi(channelname);
    return response;
  }

  Future<CategoreiesNewsModel> fetchCategoryNewsApi(String categoryname) async {
    final response = await _repo.fetchCategoryNewsApi(categoryname);
    return response;
  }
}
