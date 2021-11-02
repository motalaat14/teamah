import 'dart:convert';

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
import 'package:teamah/layouts/auth/active_account/ActiveAccount.dart';
import 'package:teamah/layouts/auth/login/Login.dart';
import 'package:teamah/layouts/auth/reset_password/ResetPassword.dart';
// import 'package:teamah/layouts/home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../res.dart';

class ForgetPassword extends StatefulWidget {

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<ScaffoldState> _scaffold=new GlobalKey();
  GlobalKey<FormState> _formKey=new GlobalKey();
  TextEditingController _phone=new TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 70),
            children: [
              Image(
                image: AssetImage(Res.logoWhite),
                fit: BoxFit.contain,
                height: 120,
              ),

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Text(tr("restorePassword"),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: MyColors.offPrimary,),),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(tr("enterActivePhone"),style: TextStyle(fontSize: 13,color: MyColors.grey,),),
                            ),
                          ],
                        ),
                      ),

                      RichTextFiled(
                        controller: _phone,
                        label: tr("phone"),
                        type: TextInputType.emailAddress,
                        margin: EdgeInsets.only(top: 20,bottom: 10),
                        fillColor: MyColors.secondary.withOpacity(.5),
                        action: TextInputAction.next,
                      ),

                      CustomButton(
                        title: tr("confirm"),
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                        onTap: (){
                          if(_phone.text==""){
                            Fluttertoast.showToast(msg: tr("enterPhone"));
                          }else{
                            forgetPassword();
                          }
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


  Future forgetPassword() async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    // if(_new.text==""||_conform.text==""){
    //   Fluttertoast.showToast(msg: "ادخل كلمة المرور الجديدة",);
    // }else if(_new.text!=_conform.text){
    //   Fluttertoast.showToast(msg: "كلمتي المرور غير متطابقتين",);
    // }else{
      LoadingDialog.showLoadingDialog();
      final url = Uri.https(URL, "api/forget_password_code");
      try {
        final response = await http.post(url,
          body: {
            "phone": "${_phone.text}",
            "lang": "${preferences.getString("lang")}",
          },
        ).timeout( Duration(seconds: 7), onTimeout: () {throw 'no internet please connect to internet';},);
        final responseData = json.decode(response.body);
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          print("------------ 200");
          print(responseData);
          if(responseData["key"]=="success"){
            print("------------ success");
            Fluttertoast.showToast(msg: responseData["msg"]);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>ResetPassword(phone: _phone.text)), (route) => false);
          }else{
            print("------------ else");
            Fluttertoast.showToast(msg: responseData["msg"]);
          }
        }
      } catch (e) {
        print("fail 222222222   $e}" );
      }
    // }
  }

}
