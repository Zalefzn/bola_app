import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/bannerPage/banner.dart';
import 'package:soccer_app/provider/clubProvider.dart';
import 'package:soccer_app/screen/home/homeClub.dart';
import 'package:soccer_app/screen/home/homeStadium.dart';
import 'package:soccer_app/screen/loginPage/loginPage.dart';
import 'package:soccer_app/splashScreen/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ClubProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/banner': (context) => const BannerPage(),
          '/login': (context) => const LoginPage(),
          '/homeclub': (context) => const HomePageClub(),
          '/homestadium': (context) => const HomePageStadium(),
        },
      ),
    );
  }
}
