import 'package:flutter/material.dart';
import 'package:soccer_app/model/clubModel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/provider/clubProvider.dart';
import 'package:soccer_app/screen/detailPage/detailClub.dart';
import 'package:soccer_app/utilities/screenSize/screenSize.dart';
import 'package:soccer_app/utilities/theme/theme.dart';

class ClubCard extends StatefulWidget {
  ClubModel club;
  ClubCard(this.club, {Key? key}) : super(key: key);
  @override
  State<ClubCard> createState() => _ClubCard();
}

class _ClubCard extends State<ClubCard> {
  var loading = false;
  var image = false;

  @override
  void initState() {
    setState(() {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          loading = false;
        });
      });
      loading = true;
    });
    getDataClub();
    super.initState();
  }

  getDataClub() async {
    await Provider.of<ClubProvider>(context, listen: false).getClub();
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailClub(widget.club)));
      },
      child: loading
          ? SizedBox(
              height: 120,
              width: SizeConfig.blockHorizontal * 80,
              child: Shimmer.fromColors(
                child: const Card(color: Colors.grey),
                baseColor: backgroundColor2,
                highlightColor: Colors.grey.shade400,
                direction: ShimmerDirection.ltr,
              ))
          : Container(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 1,
              ),
              height: 120,
              width: SizeConfig.blockHorizontal * 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.8,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.club.pictClub1)),
                borderRadius: BorderRadius.circular(20),
                color: buttonColor3,
              ),
              child: Center(
                child: Text(widget.club.nameClub,
                    style: TextStyle(
                        color: textColor1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
            ),
    );
  }
}
