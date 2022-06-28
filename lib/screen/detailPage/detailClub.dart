import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soccer_app/utilities/screenSize/screenSize.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:soccer_app/model/clubModel.dart';
import 'package:soccer_app/utilities/theme/theme.dart';

class DetailClub extends StatefulWidget {
  ClubModel club;
  DetailClub(this.club, {Key? key}) : super(key: key);

  @override
  State<DetailClub> createState() => _DetailClub();
}

class _DetailClub extends State<DetailClub> {
  void launchURL(String url) async {
    url = Uri.encodeFull(url);
    if (await launcher.canLaunchUrl(Uri.parse(url))) {
      await launcher.launchUrl(Uri.parse(url));
    } else {
      throw 'Unknown error, can\'t launch the URL.';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget headers() {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/homeclub');
            },
            icon: Icon(Icons.chevron_left, size: 40, color: buttonColor1)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
              onPressed: () => launchURL('https://${widget.club.youtubeClub}'),
              icon: Icon(Icons.ondemand_video_rounded,
                  size: 30, color: buttonColor5)),
        ),
      ]);
    }

    Widget buttonContent() {
      Widget buttonModalShowContent() {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockHorizontal * 5,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => launchURL("https://${widget.club.facebookClub}"),
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/facebook.png')))),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => launchURL("https://${widget.club.instagramClub}"),
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/instagram.png')))),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => launchURL("https://${widget.club.twitterClub}"),
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/twitter.png')))),
              )
            ],
          ),
        );
      }

      Widget contentShowModalButton() {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.club.stadiumName,
                  style: TextStyle(
                      color: textColor1, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Text(widget.club.nameLeague,
                  style: TextStyle(
                      color: textColor1, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Container(
                height: 130,
                width: 320,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(widget.club.descClub,
                          style: TextStyle(
                              fontSize: 10,
                              color: textColor1,
                              fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget headersShowModalButton() {
        return Column(
          children: [
            const SizedBox(height: 20),
            Container(
                height: 7,
                width: 80,
                decoration: BoxDecoration(
                    color: backgroundColor2,
                    borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 20),
            Text(widget.club.nameClub,
                style: TextStyle(
                    color: textColor1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('born : ',
                    style: TextStyle(
                      color: buttonColor2,
                      fontSize: 12,
                    )),
                Text(widget.club.bornClub,
                    style: TextStyle(
                      color: buttonColor2,
                      fontSize: 12,
                    )),
              ],
            )
          ],
        );
      }

      return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            margin: const EdgeInsets.only(bottom: 20, left: 15),
            height: 80,
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.club.logoClub))),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.club.nameClub,
                        style: TextStyle(
                            color: textColor1,
                            fontSize: 25,
                            fontWeight: FontWeight.w700)),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            barrierColor: buttonColor3.withOpacity(0.1),
                            backgroundColor: backgroundColor1.withOpacity(0.7),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(70),
                                topRight: Radius.circular(70),
                              ),
                            ),
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                    height: 370,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(70),
                                            topRight: Radius.circular(70))),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          headersShowModalButton(),
                                          const SizedBox(height: 20),
                                          contentShowModalButton(),
                                          const SizedBox(height: 20),
                                          buttonModalShowContent()
                                        ],
                                      ),
                                    )),
                              );
                            });
                      },
                      child: Text('Read More',
                          style: TextStyle(
                              color: textColor4,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ],
            )),
      );
    }

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.4,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.club.pictTeam2))),
              ),
            ),
            headers(),
            buttonContent()
          ],
        ),
      ),
    );
  }
}
