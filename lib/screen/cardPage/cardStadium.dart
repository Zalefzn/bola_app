import 'package:flutter/material.dart';
import 'package:soccer_app/model/clubModel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/provider/clubProvider.dart';
import 'package:soccer_app/screen/detailPage/detailStadium.dart';
import 'package:soccer_app/utilities/screenSize/screenSize.dart';
import 'package:soccer_app/utilities/theme/theme.dart';

class StadiumCard extends StatefulWidget {
  ClubModel stadium;
  StadiumCard(this.stadium, {Key? key}) : super(key: key);
  @override
  State<StadiumCard> createState() => _StadiumCard();
}

class _StadiumCard extends State<StadiumCard> {
  var loading = false;

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailStadium(widget.stadium)));
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
                    opacity: 0.6,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.stadium.imageStadium)),
                borderRadius: BorderRadius.circular(20),
                color: buttonColor3,
              ),
              child: Center(
                child: Text(widget.stadium.stadiumName,
                    style: TextStyle(
                        color: textColor1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
            ),
    );
  }
}
