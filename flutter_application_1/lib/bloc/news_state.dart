part of 'news_bloc.dart';

sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsSuccess extends NewsState {
  NewsChannelHeadLinesModel newsChannelHeadLinesModel;
  NewsSuccess({required this.newsChannelHeadLinesModel});
}

final class NewsFailure extends NewsState {
  final String error;
  NewsFailure(this.error);
}

//final class CategoriesLoading extends NewsState {}

// final class CategoriesSuccess extends NewsState {
//   CategoreiesNewsModel cateoriesModel;
//   CategoriesSuccess(this.cateoriesModel);
// }

// final class CategoriesFailure extends NewsState {
//   final String error;
//   CategoriesFailure(this.error);
// }
