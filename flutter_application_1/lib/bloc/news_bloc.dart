import 'package:flutter_application_1/model/categories_news_model.dart';
import 'package:flutter_application_1/model/news_channel_model.dart';
import 'package:flutter_application_1/repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository newsRepository;
  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<FetchNewsChannelEvent>(_fetchNewsChannel);
    // on<FetchCategoryEvent>(_fetchCategory);
  }
  @override
  void onChange(Change<NewsState> change) {
    super.onChange(change);
    print('NewsBloc - Change - $change');
  }

  @override
  void onTransition(Transition<NewsEvent, NewsState> transition) {
    super.onTransition(transition);
    print('NewsBloc - Transition - $transition');
  }

  void _fetchNewsChannel(FetchNewsChannelEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final newsChannel = await newsRepository.fetchNewsHeadlinesApi(event.channelId);
      emit(NewsSuccess(newsChannelHeadLinesModel: newsChannel));
    } catch (e) {
      emit(NewsFailure(e.toString()));
    }
  }

  // void _fetchCategory(FetchCategoryEvent event, Emitter<NewsState> emit) async {
  //   emit(NewsLoading());
  //   try {
  //     final newsCategory = await newsRepository.fetchCategoryNewsApi(event.categoryId);
  //     emit(CategoriesSuccess(newsCategory));
  //   } catch (e) {
  //     emit(NewsFailure(e.toString()));
  //   }
  // }
}
