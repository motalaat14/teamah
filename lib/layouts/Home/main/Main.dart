import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/helpers/customs/Badge.dart';
import 'package:teamah/helpers/customs/RichTextFiled.dart';
import 'package:teamah/layouts/Home/main/DeptDetails.dart';
import 'package:teamah/layouts/Home/notifications/Notifications.dart';
import 'package:teamah/layouts/more/contact_us/ContactUs.dart';
import '../../../res.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: MyColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image(
                  image: ExactAssetImage(
                    Res.logoWhite,
                  ),
                  width: 65,
                ),
              ),
              InkWell(
                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (c) => Notifications())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Badge(
                    value: "3",
                    color: MyColors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
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

        // AppBar(
        //   title: Padding(
        //     padding: const EdgeInsets.only(top: 20),
        //     child: Image(
        //       image: ExactAssetImage(Res.logoWhite,),
        //       width: 60,
        //       height: 80,
        //     ),
        //   ),
        //   centerTitle: true,
        //   // elevation: 0,
        //   actions: [
        //     InkWell(
        //       onTap: (){
        //         Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ContactUs()));
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 20),
        //         child: Icon(CupertinoIcons.bell_fill,size: 28,),
        //       ),
        //     ),
        //   ],
        // ),
      ),

      body: ListView(
        children: [
          Container(
            height: 140,
            padding: EdgeInsets.only(top: 5),
            child: Swiper(
              duration: 1000,
              autoplay: true,
              itemCount: 3,
              fade: .6,
              viewportFraction: .86,
              scrollDirection: Axis.horizontal,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
              ),
              scale: .95,
              itemBuilder: (c, i) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .2, color: MyColors.accent),
                    color: MyColors.accent.withOpacity(.1),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.indiaimagine.com/wp-content/uploads/2019/08/Indian_Food_Cover.jpg"),
                        fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr("bestSeller"),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.offPrimary),),
                Text(tr("all"),style: TextStyle(fontSize: 16,),),
              ],
            ),
          ),
          Container(
            height: 175,
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (c,i){
                return bestSellerItem(
                  id: 1,
                  img: "https://mpng.subpng.com/20210412/soq/transparent-burger-icon-summer-icon-60743b9f903914.7765810116182301755907.jpg",
                  title: "سوبر برجر",
                  price: "45",
                  rate: 4.0,
                );
                },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr("categories"),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.offPrimary),),
                Text(tr("all"),style: TextStyle(fontSize: 16,),),
              ],
            ),
          ),
          Container(
            height: 190,
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (c,i){
                return categoryItem(
                  id: 1,
                  img: "https://i.pinimg.com/originals/85/c5/9b/85c59b35b380722e63017b3538faecd4.jpg",
                  title: "الطبخ الهندي",
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bestSellerItem({int id, String img, title,price,double rate}) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => DeptDetails(id: id, name: title, img: img))),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
        child: Container(
          width: MediaQuery.of(context).size.width*.28,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
                    child: Icon(Icons.favorite_border,size: 20,color: MyColors.primary,),
                  ),
                ],
              ),
              Center(
                child: Image(
                  image: NetworkImage(img),
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(title, style: TextStyle(fontSize: 14,color: MyColors.primary)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(price, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: MyColors.offPrimary)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(tr("rs"), style: TextStyle(fontSize: 14,color: MyColors.primary)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
                child: RatingBar.builder(
                  initialRating: rate,
                  minRating: 1,
                  itemSize: 16,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _) => Icon(Icons.star, color: MyColors.primary),
                  onRatingUpdate: (rating) {print(rating);},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryItem({int id, String img, title}) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => DeptDetails(id: id, name: title, img: img))),
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
            child: Container(
              height: MediaQuery.of(context).size.width*.38,
              width: MediaQuery.of(context).size.width*.38,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),

          Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: MyColors.primary),),


        ],
      ),
    );
  }

}
