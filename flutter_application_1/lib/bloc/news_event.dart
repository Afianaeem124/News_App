part of 'news_bloc.dart';

sealed class NewsEvent {}

class FetchNewsChannelEvent extends NewsEvent {
  final String channelId;

  FetchNewsChannelEvent({required this.channelId});
}

class FetchCategoryEvent extends NewsEvent {
  final String categoryId;

  FetchCategoryEvent({required this.categoryId});
}
