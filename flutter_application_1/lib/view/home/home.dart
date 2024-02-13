import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Routes/routes_name.dart';
import 'package:flutter_application_1/bloc/news_bloc.dart';
import 'package:flutter_application_1/model/categories_news_model.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/view/news_detail.dart';
import 'package:flutter_application_1/view_model/newsModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, buzzfeed, bbcsport, cnn, reuters }

FilterList? selectedMenu;

class _HomeScreenState extends State<HomeScreen> {
  final NewsViewModel _newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsBloc>().add(FetchNewsChannelEvent(channelId: 'bbc-news'));
    //context.read<NewsBloc>().add(FetchCategoryEvent(categoryId: 'general'));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.categories);
                },
                icon: Image.asset(
                  'assets/category_icon.png',
                  height: 25,
                )),
          ),
          title: const Center(
              child: Text(
            'News',
            //style: GoogleFonts.salsa(fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: [
            PopupMenuButton<FilterList>(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                  size: 25,
                ),
                initialValue: selectedMenu,
                onSelected: (FilterList item) {
                  if (FilterList.bbcNews.name == item.name) {
                    name = 'bbc-news';
                  }
                  if (FilterList.aryNews.name == item.name) {
                    name = 'ary-news';
                  }
                  if (FilterList.bbcsport.name == item.name) {
                    name = "bbc-sport";
                  }
                  if (FilterList.cnn.name == item.name) {
                    name = 'cnn';
                  }
                  if (FilterList.buzzfeed.name == item.name) {
                    name = 'buzzfeed';
                  }
                  if (FilterList.reuters.name == item.name) {
                    name = 'reuters';
                  }
                  context.read<NewsBloc>().add(FetchNewsChannelEvent(channelId: name));
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      const PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews,
                        child: Text('BBC News'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.aryNews,
                        child: Text('Ary News'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.cnn,
                        child: Text('CNN'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.buzzfeed,
                        child: Text('Buzzfeed'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.reuters,
                        child: Text('Reuters'),
                      ),
                      const PopupMenuItem<FilterList>(
                        value: FilterList.bbcsport,
                        child: Text('BBC Sport'),
                      ),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
                height: height * .55,
                width: width,
                child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
                  if (state is NewsFailure) {
                    return Text(state.error.toString());
                  }
                  if (state is! NewsSuccess) {
                    return const Center(
                      child: SpinKitSpinningLines(
                        color: AppColors.loadingGColor,
                        size: 50,
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.newsChannelHeadLinesModel.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(state.newsChannelHeadLinesModel.articles![index].publishedAt.toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                      state.newsChannelHeadLinesModel.articles![index].urlToImage.toString(),
                                      state.newsChannelHeadLinesModel.articles![index].title.toString(),
                                      state.newsChannelHeadLinesModel.articles![index].publishedAt.toString(),
                                      state.newsChannelHeadLinesModel.articles![index].author.toString(),
                                      state.newsChannelHeadLinesModel.articles![index].description.toString(),
                                      state.newsChannelHeadLinesModel.articles![index].content.toString(),
                                      state.newsChannelHeadLinesModel.articles![index].source!.name.toString())));
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: height * .6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: state.newsChannelHeadLinesModel.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const SpinKitCircle(
                                      color: AppColors.loadingyColor,
                                      size: 50,
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.error_outline,
                                      color: AppColors.errorColor,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      height: height * .22,
                                      alignment: Alignment.bottomCenter,
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Text(
                                              state.newsChannelHeadLinesModel.articles![index].title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.displayMedium,
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: width * .7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  state.newsChannelHeadLinesModel.articles![index].source!.name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<CategoreiesNewsModel>(
                  future: _newsViewModel.fetchCategoryNewsApi('General'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Center(
                          child: SpinKitSpinningLines(
                            color: AppColors.loadingGColor,
                            size: 50,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                    placeholder: (context, url) => const SpinKitCircle(
                                      color: AppColors.loadingyColor,
                                      size: 50,
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.error_outline,
                                      color: AppColors.errorColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height * .18,
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title.toString(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                          maxLines: 3,
                                        ),
                                        const Spacer(),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Expanded(
                                            child: Text(
                                              snapshot.data!.articles![index].source!.name.toString(),
                                              style: Theme.of(context).textTheme.titleMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            style: Theme.of(context).textTheme.titleSmall,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ])
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
