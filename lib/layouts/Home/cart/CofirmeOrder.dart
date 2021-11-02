import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/customs/CustomButton.dart';
import 'package:teamah/helpers/customs/RichTextFiled.dart';
import 'package:teamah/layouts/Home/cart/MapScreen.dart';
import 'package:teamah/layouts/Home/cart/Successful.dart';

class ConfirmOrder extends StatefulWidget {

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  bool online=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.offWhite,
      appBar: AppBar(
        title: Text(tr("confirmOrder")),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: .5,color: MyColors.grey)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("${tr("total")} : "),
                            Text(tr("120"),style: TextStyle(color: MyColors.primary,),),
                            Text(" ${tr("rs")} ",style: TextStyle(color: MyColors.grey,),),
                            Text(tr("withVAT"),style: TextStyle(fontSize: 13),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text("${tr("deliveryPrice")} : "),
                              Text(tr("12"),style: TextStyle(color: MyColors.primary,),),
                              Text(" ${tr("rs")} ",style: TextStyle(color: MyColors.grey,),),
                            ],
                          ),
                        ),
                        Divider(color: MyColors.black,),
                        Row(
                          children: [
                            Text(tr("orderDetails"),style: TextStyle(fontSize: 16),),
                          ],
                        ),


                        Container(
                          height: 240,
                          child: ListView.builder(
                            itemCount: 3,
                              itemBuilder: (c,i){
                                return orderItem(
                                  id: 1,
                                  title: "اسم المنتج",
                                  price: "29",
                                  img: "https://bazar.vircart.ae/uploads/5/21/08/1708211629197284611b93e4284b0.webp",
                                );
                              },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: Row(
                      children: [
                        Text(tr("notes"),style: TextStyle(fontSize: 16),),
                      ],
                    ),
                  ),
                  RichTextFiled(
                    height: 120,
                    type: TextInputType.text,
                    label: tr("writeNotes"),
                    labelColor: MyColors.grey,
                    max: 10,
                    min: 6,
                  ),
                ],
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    title: tr("online"),
                    textSize: 13,
                    textColor: online? MyColors.white : MyColors.primary,
                    width: MediaQuery.of(context).size.width*.40,
                    height: 40,
                    color: online? MyColors.primary : MyColors.white,
                    borderRadius: BorderRadius.circular(5),
                    borderColor: MyColors.primary,
                    icon: online ?Icons.check:null,
                    onTap: (){
                      setState(() {
                        online = true;
                      });
                    },
                  ),
                  CustomButton(
                    title: tr("cash"),
                    textSize: 13,
                    textColor: online? MyColors.primary : MyColors.white,
                    width: MediaQuery.of(context).size.width*.40,
                    height: 40,
                    color: online? MyColors.white : MyColors.primary,
                    borderColor: MyColors.primary,
                    borderRadius: BorderRadius.circular(5),
                    icon: online ? null : Icons.check,
                    onTap: (){
                      setState(()=>online = false);
                    },
                  ),

                ],
              ),
              CustomButton(
                title: tr("confirm"),
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>Successful()), (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget orderItem({int id,String title,price,img}){
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(title,style: TextStyle(fontSize: 16),),
              ),
              Row(
                children: [
                  Text("39",style: TextStyle(fontSize: 16,color: MyColors.primary,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(tr("rs"),style: TextStyle(color: MyColors.grey),),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width*.24,
            height: 75,
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: .5,color: MyColors.primary),
                image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)
            ),
          ),
        ],
      ),
    );
  }


}
