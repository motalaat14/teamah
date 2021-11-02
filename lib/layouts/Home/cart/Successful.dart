import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/customs/CustomButton.dart';
import 'package:teamah/layouts/home/Home.dart';
import 'package:teamah/res.dart';

class Successful extends StatefulWidget {
  @override
  _SuccessfulState createState() => _SuccessfulState();
}

class _SuccessfulState extends State<Successful> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => Home()), (route) => false);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.2,bottom: 30),
                    child: Image(
                      image: ExactAssetImage(Res.paySuccess),
                      width: MediaQuery.of(context).size.width*.7,
                    ),
                  ),
                  Text(
                    tr("suc"),
                    style: TextStyle(
                        color: MyColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomButton(
                title: tr("backHome"),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {return Home();}), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
