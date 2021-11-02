import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamah/helpers/constants/LoadingDialog.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/constants/base.dart';
import 'package:teamah/helpers/customs/CustomButton.dart';
import 'package:teamah/helpers/customs/RichTextFiled.dart';
import 'package:teamah/layouts/Home/Home.dart';
import 'package:teamah/layouts/auth/active_account/ActiveAccount.dart';
import 'package:teamah/layouts/auth/forget_password/ForgetPassword.dart';
// import 'package:teamah/layouts/home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../res.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<ScaffoldState> _scaffold=new GlobalKey();
  GlobalKey<FormState> _formKey=new GlobalKey();
  TextEditingController _phone=new TextEditingController();
  TextEditingController _pass=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
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
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 70),
            children: [
              Image(
                image: AssetImage(Res.logoWhite),
                fit: BoxFit.contain,
                height: 120,
              ),

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Text(tr("welcomeBack"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: MyColors.offPrimary,),),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(tr("loginWithUs"),style: TextStyle(fontSize: 14,color: MyColors.grey,),),
                            ),
                          ],
                        ),
                      ),

                      RichTextFiled(
                        controller: _phone,
                        label: tr("phone"),
                        type: TextInputType.phone,
                        margin: EdgeInsets.only(top: 20,bottom: 10),
                        action: TextInputAction.next,
                      ),

                      RichTextFiled(
                        controller: _pass,
                        label: tr("password"),
                        type: TextInputType.text,
                        margin: EdgeInsets.only(top: 5,bottom: 20),
                        icon: Icon(Icons.visibility_rounded,color: MyColors.grey.withOpacity(.6),),
                      ),


                      InkWell(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>ForgetPassword()));
                        },
                        child: Align(
                          alignment: Alignment.bottomLeft,
                            child: Text(tr("forgetPassword"),style: TextStyle(fontSize: 13,color: MyColors.primary,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),)),
                      ),


                      CustomButton(
                          title: tr("login"),
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                          onTap: (){
                            login();
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>Home()), (route) => false,);
                            //
                            // Navigator.push(context, CupertinoPageRoute(builder: (context)=>Home()));
                          },
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.25,
                            height: 2,
                            color: MyColors.grey.withOpacity(.4),
                          ),

                          Text(tr("dontHaveAccount"),style: TextStyle(fontSize: 13,color: MyColors.grey,),),

                          Container(
                            width: MediaQuery.of(context).size.width*.25,
                            height: 2,
                            color: MyColors.grey.withOpacity(.4),
                          ),
                        ],
                      ),

                      CustomButton(
                        title: tr("register"),
                        color: MyColors.secondary,
                        borderColor: MyColors.primary,
                        textColor: MyColors.primary,
                        margin: EdgeInsets.symmetric(vertical: 24),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                      ),



                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String uuid ;
  void getUuid()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    print("uuid get token >>>> ${preferences.getString("fcmToken")}");
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    if(Platform.isAndroid){
      var build = await deviceInfoPlugin.androidInfo;
      uuid = build.androidId;
      preferences.setString("uuid", uuid);
    }else if(Platform.isIOS){
      var data = await deviceInfoPlugin.iosInfo;
      uuid = data.identifierForVendor;
      preferences.setString("uuid", uuid);
    }
  }

  Future login() async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    print("========> login");
    LoadingDialog.showLoadingDialog();
    print(preferences.getString("fcmToken"));
    final url = Uri.https(URL, "api/login");
    try {
      final response = await http.post(url,
        body: {
          "uuid":"$uuid",
          "phone": "${_phone.text}",
          "password": "${_pass.text}",
          "device_id": preferences.getString("fcmToken"),
          "device_type": Platform.isIOS ?"ios":"android",
          "lang":preferences.getString("lang"),
        },
      ).timeout(Duration(seconds: 10), onTimeout: () {throw 'no internet please connect to internet';});
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print(responseData);
        if(responseData["key"]=="success"){
          preferences.setString("userId", responseData["data"]["user_base_info"]["id"].toString());
          preferences.setString("name",   responseData["data"]["user_base_info"]["name"]);
          preferences.setString("phone",  responseData["data"]["user_base_info"]["phone"]);
          preferences.setString("email",  responseData["data"]["user_base_info"]["email"]);
          preferences.setString("token",  responseData["data"]["user_base_info"]["token"]);
          preferences.setString("image",  responseData["data"]["user_base_info"]["image"]);
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>Home()), (route) => false,);
        }else if(responseData["key"]=="needActive"){
          Fluttertoast.showToast(msg: responseData["data"]);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>ActiveAccount(phone: _phone.text,)), (route) => false,);
        }else{
          Fluttertoast.showToast(msg: responseData["msg"]);
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("fail 222222222   $e}" );
    }
  }


}
