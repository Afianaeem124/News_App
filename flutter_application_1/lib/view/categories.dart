import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/categories_news_model.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/view_model/newsModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final NewsViewModel _newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  String categoryname = 'General';

  List<String> categoryList = ['General', 'Entertainment', 'Health', 'Sports', 'Business', 'Technology'];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Container(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            categoryname = categoryList[index];
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: categoryname == categoryList[index] ? AppColors.darkorangeColor : AppColors.orangeColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Center(
                                child: Text(
                                  categoryList[index].toString(),
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<CategoreiesNewsModel>(
                  future: _newsViewModel.fetchCategoryNewsApi(categoryname),
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
                        scrollDirection: Axis.vertical,
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
                                Padding(padding: EdgeInsets.only(left: 15)),
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
