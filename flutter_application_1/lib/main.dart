import 'package:flutter/material.dart';
import 'package:flutter_application_1/Routes/routes.dart';
import 'package:flutter_application_1/Routes/routes_name.dart';
import 'package:flutter_application_1/bloc/news_bloc.dart';
import 'package:flutter_application_1/repository/news_repository.dart';
import 'package:flutter_application_1/view/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => NewsRepository(),
        child: BlocProvider(
          create: (context) => NewsBloc(context.read<NewsRepository>()),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              appBarTheme: AppBarTheme(titleTextStyle: GoogleFonts.salsa(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
              textTheme: TextTheme(
                  displayMedium: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                  displaySmall: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
                  titleMedium: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: const Color.fromARGB(255, 44, 44, 44))),
            ),
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoutes,
          ),
        ));
  }
}

///436677f67002475aab94d709d225211c
/////https://newsapi.org/v2/everything?q=bitcoin&apiKey=436677f67002475aab94d709d225211c
/// 
///

