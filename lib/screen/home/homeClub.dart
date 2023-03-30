import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:soccer_app/provider/clubProvider.dart';
import 'package:soccer_app/screen/cardPage/cardClub.dart';
import 'package:soccer_app/utilities/screenSize/screenSize.dart';
import 'package:soccer_app/utilities/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageClub extends StatefulWidget {
  const HomePageClub({Key? key}) : super(key: key);

  @override
  State<HomePageClub> createState() => _HomePageClub();
}

class _HomePageClub extends State<HomePageClub> {
  var username;
  var favoriteClub;
  var city;

  var _folded = true;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    getDataText();
    getDataClub();
    super.initState();
  }

  getDataText() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username") ?? "-";
      favoriteClub = preferences.getString("favoriteClub") ?? "-";
      city = preferences.getString("city") ?? "-";
    });
  }

  getDataClub() async {
    await Provider.of<ClubProvider>(context, listen: false).getClub();
  }

  @override
  Widget build(BuildContext context) {
    ClubProvider clubProvider = Provider.of<ClubProvider>(context);

    onSearchTextChanged(String text) async {
      clubProvider.search.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      clubProvider.clubs.forEach((data) {
        if (data.nameClub.toLowerCase().contains(text) ||
            data.bornClub.toString().contains(text))
          clubProvider.search.add(data);
      });

      setState(() {});
    }

    Widget headers() {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildPopDialog(context),
                  );
                },
                icon: Icon(Icons.settings, color: buttonColor1, size: 25)),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: _folded ? 32 : 200,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: buttonColor1,
                boxShadow: kElevationToShadow[6],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(left: 17),
                    child: !_folded
                        ? TextFormField(
                            onChanged: onSearchTextChanged,
                            decoration: InputDecoration(
                              hintText: 'search here...',
                              hintStyle: TextStyle(
                                color: textColor2,
                              ),
                              border: InputBorder.none,
                            ),
                          )
                        : null,
                  )),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(_folded ? 32 : 0),
                            topRight: const Radius.circular(32),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              _folded ? Icons.search : Icons.close,
                              color: buttonColor3,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              controller.clear();
                              onSearchTextChanged('');
                              _folded = !_folded;
                            });
                          },
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget profile() {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        child: Row(
          children: [
            const Image(
              image: AssetImage('assets/profile.png'),
              height: 70,
              width: 70,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$username',
                    style: TextStyle(
                      color: textColor1,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    )),
                Text('$favoriteClub',
                    style: TextStyle(
                      color: textColor3,
                    )),
                Text('$city',
                    style: TextStyle(
                      color: textColor3,
                    )),
              ],
            ),
          ],
        ),
      );
    }

    Widget contentPageButton() {
      return Container(
        height: SizeConfig.blockVertical * 65,
        width: 375,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(70), topRight: Radius.circular(70)),
          color: backgroundColor2,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/homeclub');
                    },
                    child: Container(
                        height: 20,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buttonColor3,
                        ),
                        child: Center(
                          child: Text('Club',
                              style: TextStyle(
                                  color: textColor1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                        ))),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/homestadium');
                    },
                    child: Container(
                        height: 20,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: buttonColor2,
                        ),
                        child: Center(
                          child: Text('Stadium',
                              style: TextStyle(
                                  color: textColor2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                        ))),
              ],
            ),
            Container(
              height: SizeConfig.blockVertical * 54,
              width: 320,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                    children: clubProvider.search.length != 0 ||
                            controller.text.toLowerCase().isNotEmpty
                        ? clubProvider.search
                            .map((search) => ClubCard(search))
                            .toList()
                        : clubProvider.clubs
                            .map((club) => ClubCard(club))
                            .toList()),
              ),
            ),
          ],
        ),
      );
    }

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            headers(),
            const SizedBox(height: 30),
            profile(),
            const SizedBox(height: 50),
            contentPageButton(),
          ],
        ),
      ),
    );
  }
}

_buildPopDialog(BuildContext context) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    child: AlertDialog(
        title: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Are you sure want\nto exit the app?',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        color: buttonColor3,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text('Yes',
                            style: TextStyle(color: textColor1, fontSize: 14))),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/homeclub');
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        color: buttonColor2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text('No',
                            style: TextStyle(color: textColor3, fontSize: 14))),
                  ))
            ],
          ),
        ],
      ),
    )),
  );
}
