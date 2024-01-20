import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Routes/routes_name.dart';
import 'package:flutter_application_1/model/categories_news_model.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/view/news_detail.dart';
import 'package:flutter_application_1/view_model/newsModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
          title: Center(
              child: Text(
            'News',
            //style: GoogleFonts.salsa(fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: [
            PopupMenuButton<FilterList>(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                icon: Icon(
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
                  setState(() {
                    selectedMenu = item;
                  });
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      PopupMenuItem<FilterList>(
                        child: Text('BBC News'),
                        value: FilterList.bbcNews,
                      ),
                      PopupMenuItem<FilterList>(
                        child: Text('Ary News'),
                        value: FilterList.aryNews,
                      ),
                      PopupMenuItem<FilterList>(
                        child: Text('CNN'),
                        value: FilterList.cnn,
                      ),
                      PopupMenuItem<FilterList>(
                        child: Text('Buzzfeed'),
                        value: FilterList.buzzfeed,
                      ),
                      PopupMenuItem<FilterList>(
                        child: Text('Reuters'),
                        value: FilterList.reuters,
                      ),
                      PopupMenuItem<FilterList>(
                        child: Text('BBC Sport'),
                        value: FilterList.bbcsport,
                      ),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder(
                  future: _newsViewModel.fetchNewsHeadlinesApi(name),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitSpinningLines(
                          color: AppColors.loadingGColor,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailScreen(
                                          snapshot.data!.articles![index].urlToImage.toString(),
                                          snapshot.data!.articles![index].title.toString(),
                                          snapshot.data!.articles![index].publishedAt.toString(),
                                          snapshot.data!.articles![index].author.toString(),
                                          snapshot.data!.articles![index].description.toString(),
                                          snapshot.data!.articles![index].content.toString(),
                                          snapshot.data!.articles![index].source!.name.toString())));
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
                                        imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => SpinKitCircle(
                                          color: AppColors.loadingyColor,
                                          size: 50,
                                        ),
                                        errorWidget: (context, url, error) => Icon(
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
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                child: Text(
                                                  snapshot.data!.articles![index].title.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.displayMedium,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: width * .7,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data!.articles![index].source!.name.toString(),
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
                    }
                  }),
            ),
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
                                    placeholder: (context, url) => SpinKitCircle(
                                      color: AppColors.loadingyColor,
                                      size: 50,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: AppColors.errorColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title.toString(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                          maxLines: 3,
                                        ),
                                        Spacer(),
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
