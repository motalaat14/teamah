import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mdi/mdi.dart';
import 'package:teamah/helpers/constants/LoadingDialog.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/constants/base.dart';
import 'package:teamah/helpers/customs/AppBarFoot.dart';
import 'package:teamah/layouts/Home/Home.dart';
import 'package:teamah/layouts/auth/splash/Splash.dart';
import 'package:teamah/layouts/settings/notifications/Notifications.dart';
import 'package:teamah/layouts/settings/profile/Profile.dart';
import 'package:teamah/layouts/settings/repeated_questions/RepeatedQuestions.dart';
import 'package:teamah/layouts/settings/terms/Terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_us/AboutUs.dart';
import 'contact_us/ContactUs.dart';
import 'lang/LangScreen.dart';
import 'package:http/http.dart' as http;


class More extends StatefulWidget {

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  String name,phone,email,img;

  initInfo()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name= preferences.getString("name");
    phone= preferences.getString("phone");
    email= preferences.getString("email");
    img= preferences.getString("image");
  }


  @override
  void initState() {
    initInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 75),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              title:
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 45,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                              image: DecorationImage(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/a/a0/Arh-avatar.jpg"),fit: BoxFit.cover)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${tr("welcome")} , ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  Text("محمد طلعت", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("01007013818", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                InkWell(onTap: ()=>logout(), child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Mdi.logout,size: 36,color: MyColors.red,),
                )),//red
              ],
            ),
            AppBarFoot(),
          ],
        ),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          moreItem(title: tr("main"),icon: Mdi.homeOutline,
            onTap: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>Home(index: 0,)), (route) => false);},
          ),
          moreItem(title: tr("profile"),icon: Mdi.accountOutline,
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (c)=>Profile(
                img: "img",name: "name",phone: "phone",email: "email",
              )));},
          ),
          moreItem(title: tr("noti"),icon: CupertinoIcons.bell,
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (c)=>Notifications()));},
          ),
          moreItem(title: tr("lang"),icon: Mdi.web,
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (c)=>LangScreen()));},
          ),
          moreItem(title: tr("contactUs"),icon: CupertinoIcons.phone_circle,
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (c)=>ContactUs()));},
          ),
          moreItem(title: tr("popQuestions"),icon: Mdi.helpCircleOutline,
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (c)=>RepeatedQuestions()));},
    ),
          moreItem(title: tr("about"),icon: Mdi.informationOutline,
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (c)=>AboutUs()));},
          ),
          moreItem(title: tr("terms"),icon: Mdi.fileOutline,
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (c)=>Terms()));},
          ),

          // InkWell(
          //   onTap: ()=>logout(),
          //   child: Container(
          //     margin: EdgeInsets.only(top: 10),
          //     padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       border: Border.all(width: 1,color: MyColors.red),
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             Icon(Icons.logout,color: MyColors.red,),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal:6),
          //               child: Text(tr("logout"),style: TextStyle(fontSize: 16,color: MyColors.red,fontWeight: FontWeight.bold),),
          //             ),
          //           ],
          //         ),
          //         Icon(Icons.arrow_forward_ios,color: MyColors.red,),
          //       ],
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }

  Widget moreItem({IconData icon,String title,Function onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: MyColors.primary),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,color: MyColors.primary,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:6),
                  child: Text(title,style: TextStyle(fontSize: 16,color: MyColors.offPrimary,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios,color: MyColors.primary,),
          ],
        ),
      ),
    );
  }


  String uuid;
  void getUuid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      uuid = build.androidId;
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      uuid = data.identifierForVendor;
    }
  }

  Future logout() async {
    LoadingDialog.showLoadingDialog();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final url = Uri.https(URL, "api/logOut");
    try {final response = await http.post(url,
      headers: {"Authorization": "Bearer ${preferences.getString("token")}"},)
        .timeout(Duration(seconds: 9), onTimeout: () {throw 'no internet please connect to internet';},);
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print("------------ 200");
      print(responseData);
      if (responseData["key"] == "success") {
        preferences.remove("fcmToken");
        preferences.remove("userId");
        preferences.remove("token");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => Splash()), (route) => false);
      } else {
        print("------------ else");
        Fluttertoast.showToast(msg: responseData["msg"]);
      }
    }
    } catch (e,t) {
      print("error $e");
      print("error $t");
    }
  }


}
