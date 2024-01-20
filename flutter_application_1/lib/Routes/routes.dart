import 'package:flutter/material.dart';
import 'package:flutter_application_1/Routes/routes_name.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:flutter_application_1/view/home/home.dart';
import 'package:flutter_application_1/view/splash.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.categories:
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      // case RoutesName.login:
      //   return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutesName.homescreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      // case RoutesName.phone:
      //   return MaterialPageRoute(builder: (context) => PhoneAuth());
      // case RoutesName.addpost:
      //   return MaterialPageRoute(builder: (context) => AddPostScreen());
      // case RoutesName.firestorelist:
      //   return MaterialPageRoute(builder: (context) => FirestoreListScreen());
      // case RoutesName.insertfirestore:
      //   return MaterialPageRoute(builder: (context) => InsertFirestore());
      // case RoutesName.uploadImage:
      //   return MaterialPageRoute(builder: (context) => UploadImageScreen());
      //    case RoutesName.forgetpassword:
      //   return MaterialPageRoute(builder: (context) =>ForgotPasswordScreen());
      // case RoutesName.verify:
      //   return MaterialPageRoute(
      //       builder: (context) =>
      //           VerifyScreen(verificationID: settings.arguments as String));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(body: Center(child: Text('No Route Defined')));
        });
    }
  }
}
