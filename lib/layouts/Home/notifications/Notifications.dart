import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/constants/base.dart';
import 'package:teamah/helpers/customs/EmptyBox.dart';
import 'package:teamah/helpers/customs/Loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../res.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  @override
  void initState() {
    // getNotifications();
    super.initState();
  }

  // final RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondary,
      appBar: AppBar(
        title: Text(
          tr("noti"),
          style: TextStyle(fontSize: 16, color: MyColors.primary),
        ),
        iconTheme: IconThemeData(color: MyColors.primary),
        backgroundColor: MyColors.white,
      ),
      body:
          // loading ? MyLoading() : notificationModel.data.notifications.length == 0 ? EmptyBox(title: tr("noNoti"),widget: Container(),) :

          // SmartRefresher(
          // controller: refreshController,
          // onRefresh: (){
          //   setState(() {
          //     currentPage=1;
          //   });
          //   getNotifications();
          //   refreshController.refreshCompleted();
          // },

          // enablePullUp: true,
          // onLoading: (){
          //   setState(() {
          //     currentPage++;
          //   });
          //   print("-------------- $currentPage");
          //   getNotifications().then((value) {
          //     refreshController.loadComplete();
          //   });
          // },

          // child:

          ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: 6,
        // notificationModel.data.notifications.length,
        itemBuilder: (c, i) {
          return notificationItem(
              id: "1",
              // notificationModel.data.notifications[i].id.toString(),
              title: "نص الرسالة نص الاشعار",
              // notificationModel.data.notifications[i].message,
              time: "منذ 15 دقيقة"
              // notificationModel.data.notifications[i].date
              );
        },
      ),
      // ),
    );
  }

  Widget notificationItem({String id, title, time}) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
          color: MyColors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: MyColors.offWhite,
                image: DecorationImage(
                    image: ExactAssetImage(Res.logo), scale: 15.0),
                borderRadius: BorderRadius.circular(50)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        color: MyColors.offPrimary,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$time",
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // bool loading = true;
  // NotificationModel notificationModel = NotificationModel();
  // Future getNotifications() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   print("${preferences.getString("token")}");
  //   // print("---------- load page number $currentPage");
  //   final url = Uri.https(URL, "api/authUserNotifications");
  //   try {
  //     final response = await http.get(url, headers: {
  //       "Authorization": "Bearer ${preferences.getString("token")}"
  //     }).timeout(Duration(seconds: 7), onTimeout: () {throw 'no internet please connect to internet';});
  //     final responseData = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         loading = false;
  //       });
  //       print(responseData);
  //       if (responseData["key"] == "success") {
  //         print("---------------------------------------success notifications");
  //         notificationModel = NotificationModel.fromJson(responseData);
  //       } else {Fluttertoast.showToast(msg: responseData["msg"]);}
  //     }
  //   } catch (e) {print("fail 222222222   $e}");}
  // }

  // Future deleteNotification({@required String notificationId}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   print("${preferences.getString("token")}");
  //   final url = Uri.https(URL, "api/delete-notification");
  //   try {
  //     print("try 0000000");
  //     final response = await http.delete(url, body: {
  //       "lang": "${preferences.getString("lang")}",
  //       "id": notificationId
  //     }, headers: {
  //       "Authorization": "Bearer ${preferences.getString("token")}"
  //     }).timeout(
  //       Duration(seconds: 7),
  //       onTimeout: () {
  //         throw 'no internet please connect to internet';
  //       },
  //     );
  //     print("try 1111111");
  //     final responseData = json.decode(response.body);
  //     print("try 2222222");
  //     if (response.statusCode == 200) {
  //       print("try 3333333");
  //       print(responseData);
  //       if (responseData["key"] == "success") {
  //         Fluttertoast.showToast(
  //           msg: responseData["msg"],
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //         );
  //         print("try 4444444");
  //         getNotifications();
  //       } else {
  //         Fluttertoast.showToast(
  //           msg: responseData["msg"],
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     print("fail 222222222   $e}");
  //   }
  // }
}
