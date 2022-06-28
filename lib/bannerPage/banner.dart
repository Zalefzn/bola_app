import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/provider/clubProvider.dart';
import 'package:soccer_app/utilities/screenSize/screenSize.dart';
import 'package:soccer_app/utilities/theme/theme.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  State<BannerPage> createState() => _BannerPage();
}

class _BannerPage extends State<BannerPage> {
  var onPressed = false;

  getDataClub() async {
    await Provider.of<ClubProvider>(context, listen: false).getClub();
  }

  @override
  void initState() {
    getDataClub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget text() {
      return Center(
        child: Container(
            margin: const EdgeInsets.only(top: 370),
            child: Text(
              '"The ball laughs, radient, in the air\nhe brings her down, puts her to sleep\nshowers her with compliments\ndances with her, and seeing such\nthings never before seen his admires\npity their unborn grandchildren who\nwill never see them"',
              style: TextStyle(
                  fontSize: 16, color: textColor1, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            )),
      );
    }

    Widget buttonText() {
      return TextButton(
          onPressed: () {
            setState(() {
              onPressed = !onPressed;
            });
            Navigator.pushNamed(context, '/login');
          },
          child: Container(
            height: SizeConfig.blockVertical * 6,
            width: SizeConfig.blockHorizontal * 70,
            decoration: BoxDecoration(
                color: onPressed ? buttonColor1 : buttonColor4,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text('Get Started',
                  style: TextStyle(
                      color: textColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
          ));
    }

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('assets/image1.png')),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              text(),
              const SizedBox(height: 20),
              buttonText(),
            ],
          ),
        ]),
      ),
    );
  }
}
