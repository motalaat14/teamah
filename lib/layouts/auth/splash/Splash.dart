import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:teamah/layouts/auth/select_lang/SelectLang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../res.dart';


class Splash extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const Splash({Key key, this.navigatorKey}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // GlobalNotification.instance.setupNotification(widget.navigatorKey);
    _splashTimer();
    super.initState();
  }

  Future<Timer> _splashTimer() async {
    return new Timer(Duration(seconds: 2), _goToApp);
  }

  _goToApp()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString("lang")=="en"){
      changeLanguage("en",context);
      print("_____________________________________03 en");
    }else{
      changeLanguage("ar",context);
      print("_____________________________________04 ar");
    }

    if(preferences.getString("userId")!=null){
      print("---------------- user id == ${preferences.getString("userId")}");
      print("---------------- token == ${preferences.getString("token")}");
      print("---------------- fcmToken == ${preferences.getString("fcmToken")}");
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>Home()), (route) => false);
    }else{
      changeLanguage("ar",context);
      print("---------------- user id == ${preferences.getString("userId")}");
      print("---------------- token == ${preferences.getString("token")}");
      print("---------------- fcmToken == ${preferences.getString("fcmToken")}");
      print("---------------- lang == ${preferences.getString("lang")}");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>SelectLang()), (route) => false);
    }
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(image: ExactAssetImage(Res.splash),fit: BoxFit.cover)
            ),
            child: AnimationConfiguration.staggeredList(
              position: 0,
              duration: Duration(milliseconds: 500),
              child: Visibility(
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: ExactAssetImage(Res.logoWhite),scale: 3)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
