import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/customs/CustomButton.dart';
import 'package:teamah/layouts/auth/login/Login.dart';
import 'package:teamah/layouts/auth/register/UserRegister.dart';
import 'package:teamah/layouts/auth/welcome/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res.dart';

class SelectUser extends StatefulWidget {
  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  static void selectUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == "1") {
      prefs.setString("user", "1");
    } else if (user == "2") {
      prefs.setString("user", "2");
    } else if (user == "3") {
      prefs.setString("user", "3");
    } else {
      prefs.setString("user", "1");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(Res.background), fit: BoxFit.cover)),
          ),
          ListView(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                height: 120,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: ExactAssetImage(Res.logoWhite))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(tr("register"), style: TextStyle(fontSize: 22, color: MyColors.primary, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(tr("selectUser"), style: TextStyle(fontSize: 16, color: MyColors.offPrimary)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          CustomButton(
                            title: tr("user"),
                            onTap: () {
                              selectUser("1");
                              Navigator.push(context, MaterialPageRoute(builder: (c) => UserRegister()));
                            },
                          ),
                          CustomButton(
                            title: tr("chef"),
                            textColor: MyColors.primary,
                            color: MyColors.secondary,
                            borderColor: MyColors.primary,
                            onTap: () {
                              selectUser("2");
                              Navigator.push(context, MaterialPageRoute(builder: (c) => UserRegister()));
                            },
                          ),

                          CustomButton(
                            title: tr("driver"),
                            onTap: () {
                              selectUser("3");
                              Navigator.push(context, MaterialPageRoute(builder: (c) => UserRegister()));
                            },
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
