import 'package:flutter/material.dart';
import 'package:soccer_app/utilities/screenSize/screenSize.dart';
import 'package:soccer_app/utilities/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController favoriteClub = TextEditingController();
  TextEditingController city = TextEditingController();

  var onPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget inputFormFild() {
      Widget inputName() {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                    color: textColor1,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: username,
                style: TextStyle(
                  color: textColor1,
                ),
                cursorColor: textColor1,
                decoration: InputDecoration(
                    fillColor: backgroundFormFild,
                    filled: true,
                    hintText: 'Your Name',
                    hintStyle: TextStyle(color: textColor3),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor1)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ),
        );
      }

      Widget inputFavoriteClub() {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favorite Club',
                style: TextStyle(
                    color: textColor1,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: favoriteClub,
                style: TextStyle(
                  color: textColor1,
                ),
                cursorColor: textColor1,
                decoration: InputDecoration(
                    fillColor: backgroundFormFild,
                    filled: true,
                    hintText: 'Your Club',
                    hintStyle: TextStyle(color: textColor3),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor1)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ),
        );
      }

      Widget inputCity() {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'City',
                style: TextStyle(
                    color: textColor1,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: city,
                style: TextStyle(color: textColor1),
                cursorColor: textColor1,
                decoration: InputDecoration(
                    fillColor: backgroundFormFild,
                    filled: true,
                    hintText: 'Your City',
                    hintStyle: TextStyle(color: textColor3),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor1)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ),
        );
      }

      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 40,
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              inputName(),
              const SizedBox(height: 30),
              inputFavoriteClub(),
              const SizedBox(height: 30),
              inputCity(),
            ],
          ),
        ),
      );
    }

    Widget buttonLogin() {
      return Container(
          child: TextButton(
              onPressed: () async {
                setState(() {
                  onPressed = !onPressed;
                });
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('username', username.text);
                preferences.setString('favoriteClub', favoriteClub.text);
                preferences.setString('city', city.text);
                Navigator.pushNamed(context, '/homeclub');
              },
              child: Container(
                  height: SizeConfig.blockVertical * 6,
                  width: SizeConfig.blockHorizontal * 70,
                  decoration: BoxDecoration(
                      color: onPressed ? buttonColor1 : buttonColor4,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'Login',
                    style: TextStyle(
                        color: textColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )))));
    }

    Widget underButton() {
      return Container(
          child: Text('- Premier League Season -',
              style: TextStyle(
                  color: textColor1,
                  fontSize: 9,
                  fontWeight: FontWeight.w300)));
    }

    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              inputFormFild(),
              const SizedBox(height: 10),
              buttonLogin(),
              const SizedBox(height: 5),
              underButton()
            ],
          ),
        ),
      ),
    );
  }
}
