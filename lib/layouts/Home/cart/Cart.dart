import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/customs/Badge.dart';
import 'package:teamah/helpers/customs/CustomButton.dart';
import 'package:teamah/layouts/Home/cart/Checkout.dart';
import 'package:teamah/layouts/Home/notifications/Notifications.dart';
import 'package:teamah/layouts/more/contact_us/ContactUs.dart';

import '../../../res.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(tr("cart")),
            ),
            elevation: 0,
            actions: [
              InkWell(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => Notifications())),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Badge(
                    value: "3",
                    color: MyColors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: Icon(
                        CupertinoIcons.bell_fill,
                        size: 28,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          children: [
            Row(
              children: [
                Text(
                  "3",
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    tr("product"),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * .65,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (c, i) {
                    return cartItem(
                      id: 1,
                      title: "اسم المنتج",
                      img:
                          "https://mpng.subpng.com/20210412/soq/transparent-burger-icon-summer-icon-60743b9f903914.7765810116182301755907.jpg",
                      price: "25",
                      count: 1,
                    );
                  }),
            ),
            CustomButton(
              title: tr("checkOut"),
              color: MyColors.primary,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=>CheckOut()));
              },
            )
          ],
        ),
      ),
    );
  }

  int _value = 1;
  Widget cartItem({int id, String title, img, price, int count}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: .2),
          color: MyColors.offWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Text(
                      price,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        tr("rs"),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: .2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4),
                width: 50,
                height: 30,
                child: DropdownButton(
                  alignment: Alignment.center,
                  elevation: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.black,
                      fontSize: 15),
                  onTap: () {},
                  value: _value,
                  icon: Icon(Icons.expand_more),
                  items: [
                    DropdownMenuItem(
                      child: Text("1"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("2"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("3"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("4"),
                      value: 4,
                    ),
                    DropdownMenuItem(
                      child: Text("5"),
                      value: 5,
                    ),
                    DropdownMenuItem(
                      child: Text("6"),
                      value: 6,
                    ),
                  ],
                  hint: Text("    "),
                  onChanged: (int value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              )

              // Container(
              //   width: 60,height: 40,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       border: Border.all(width: .5),
              //       color: MyColors.white
              //   ),
              // ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: NetworkImage(img),
                width: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(
                        CupertinoIcons.delete,
                        size: 15,
                        color: MyColors.red,
                      ),
                    ),
                    Text(
                      tr("delete"),
                      style: TextStyle(fontSize: 13, color: MyColors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
