import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/customs/CustomButton.dart';
import 'package:teamah/helpers/customs/RichTextFiled.dart';
import 'package:teamah/layouts/Home/cart/CofirmeOrder.dart';
import 'package:teamah/layouts/Home/cart/MapScreen.dart';

class CheckOut extends StatefulWidget {

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  bool now=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.offWhite,
      appBar: AppBar(
        title: Text(tr("shippingAddress")),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      goToLocationScreen();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 200,
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: .5,color: MyColors.grey)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.location,color: MyColors.grey,),
                                      Text(tr("chooseOnMap"),style: TextStyle(color: MyColors.grey,),),
                                    ],
                                  ),
                                ),
                                Text(address??"ش عبد العزيز - الرياض",overflow: TextOverflow.ellipsis,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(country??"المملكة العربية السعودية",overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.3,
                            height: 100,
                            decoration: BoxDecoration(
                                color: MyColors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: .5,color: MyColors.grey),
                                image: DecorationImage(image: NetworkImage("https://www.google.com/maps/d/thumbnail?mid=1E9pWdjXat-6UuX98yCKkCUu79qg&hl=en"),fit: BoxFit.cover)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: Row(
                      children: [
                        Text(tr("addressDetails"),style: TextStyle(fontSize: 16),),
                      ],
                    ),
                  ),
                  RichTextFiled(
                    height: 200,
                    type: TextInputType.text,
                    label: tr("writeAddressDetails"),
                    labelColor: MyColors.grey,
                    max: 10,
                    min: 6,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        title: tr("now"),
                        textColor: now? MyColors.white : MyColors.primary,
                        width: MediaQuery.of(context).size.width*.40,
                        height: 40,
                        color: now? MyColors.primary : MyColors.white,
                        borderRadius: BorderRadius.circular(5),
                        borderColor: MyColors.primary,
                        icon: now ?Icons.check:null,
                        onTap: (){
                          setState(() {
                            now = true;
                          });
                        },
                      ),
                      CustomButton(
                        title: tr("late"),
                        textColor: now? MyColors.primary : MyColors.white,
                        width: MediaQuery.of(context).size.width*.40,
                        height: 40,
                        color: now? MyColors.white : MyColors.primary,
                        borderColor: MyColors.primary,
                        borderRadius: BorderRadius.circular(5),
                        icon: now ? null : Icons.check,
                        onTap: (){
                          setState(()=>now = false);
                        },
                      ),

                    ],
                  ),

                  now==false ? Column(
                    children: [
                      InkWell(
                        onTap: (){
                          showDatePicker();
                        },
                        child: Container(
                          child: Center(child: Text(lateDate==null?tr("selectDate"):lateDate.toString())),
                          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColors.grey),
                              color: MyColors.white
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          openTimePicker();
                        },
                        child: Container(
                          child: Center(child: Text(lateTime==null?tr("selectTime"):lateTime.toString(),)),
                          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: MyColors.grey),
                              color: MyColors.white
                          ),
                        ),
                      ),
                    ],
                  ) :Container(),
                ],
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                margin: EdgeInsets.all(20),
                title: tr("confirm"),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ConfirmOrder()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  List<dynamic> result = List();
  String address,country;
  double choseLat, choseLng ;
  Future goToLocationScreen() async {
    result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapScreen()));
    setState(() {
      address = result[0];
      choseLat = result[1];
      choseLng = result[2];
      country = result[3];
    });
  }

  DateTime lateDate;
  final f = new DateFormat('yyyy-MM-dd');
  showDatePicker() {
    return showDialog(
      context: context,
      builder: (c) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.primary,
              onPrimary: MyColors.white,
              surface: MyColors.black,
              onSurface: MyColors.black,
            ),
            dialogBackgroundColor:MyColors.white,
          ),
          child: DatePickerDialog(
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year +1),
          ),
        );
      },
    ).then((pickedDate) {
      setState(() {
        lateDate = pickedDate;
      });
    });
  }

  TimeOfDay lateTime;
  openTimePicker() {
    return showDialog(
      context: context,
      barrierColor: MyColors.offPrimary.withOpacity(.1),
      builder: (c) {
        return TimePickerTheme(
            data: TimePickerThemeData(
              backgroundColor: MyColors.white,
              dayPeriodTextColor: MyColors.black,
              helpTextStyle: TextStyle(color: MyColors.primary),
              dialTextColor: MyColors.primary,
              dialBackgroundColor: MyColors.accent,
              dialHandColor: MyColors.white
            ),
            child: TimePickerDialog(
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.dial,
            )
        );
      },
    ).then((pickedTime) {
      setState(() {
        lateTime = pickedTime;
      });
    });
  }

  
}
