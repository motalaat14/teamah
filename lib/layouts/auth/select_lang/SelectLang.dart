import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/customs/CustomButton.dart';
import 'package:teamah/layouts/auth/select_user/SelectUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res.dart';

class SelectLang extends StatefulWidget {

  @override
  _SelectLangState createState() => _SelectLangState();
}

class _SelectLangState extends State<SelectLang> {

  static void  changeLanguage(String lang,BuildContext context)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (lang == "en") {
      prefs.setString("lang", lang);
      context.locale = Locale('en', 'US');
    } else {
      context.locale=Locale('ar', 'EG');
      prefs.setString("lang", lang);
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
                image: DecorationImage(image: ExactAssetImage(Res.background),fit: BoxFit.cover)
            ),
          ),


          ListView(
            padding: EdgeInsets.symmetric(vertical: 50,horizontal: 15),
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                height: 120,
                decoration: BoxDecoration(image: DecorationImage(image: ExactAssetImage(Res.logoWhite))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(tr("lang"),style: TextStyle(fontSize: 22,color: MyColors.primary,fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(tr("selectLang"),style: TextStyle(fontSize: 16,color: MyColors.offPrimary),),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          CustomButton(
                            title: tr("langAr"),
                            onTap: (){
                              changeLanguage("ar", context);
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>SelectUser()));
                            },
                          ),

                          CustomButton(
                            title: tr("langEn"),
                            textColor: MyColors.primary,
                            color: MyColors.secondary,
                            borderColor: MyColors.primary,
                            onTap: (){
                              changeLanguage("en", context);
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>SelectUser()));
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
