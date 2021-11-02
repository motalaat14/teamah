import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:teamah/helpers/constants/MyColors.dart';
import 'package:teamah/layouts/Home/cart/Cart.dart';
import 'package:teamah/layouts/Home/main/Main.dart';
import 'package:teamah/layouts/Home/search/Search.dart';
import 'package:teamah/layouts/settings/More.dart';

import 'favorite/Favorite.dart';

class Home extends StatefulWidget {
  final int index;
  const Home({Key key, this.index}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _bottomNavIndex = 0;
  final iconList = <IconData>[Mdi.home,
    CupertinoIcons.cart_fill,
    Icons.favorite, Mdi.dotsHorizontalCircle];
  final titleList = <String>[tr("main"), tr("cart"), tr("fav"), tr("more")];
  Animation<double> animation;
  AnimationController _animationController;
  CurvedAnimation curve;
  TabController tabController;
  @override
  void initState() {
    tabController = new TabController(length: 5, vsync: this, initialIndex: 0);
    _animationController = AnimationController(duration: Duration(seconds: 0), vsync: this);
    curve = CurvedAnimation(parent: _animationController, curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(curve);
    Future.delayed(Duration(seconds: 0), () => _animationController.forward());
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        key: scaffold,
        body: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Main(),
            Cart(),
            Favorite(),
            More(),
            Search(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            tabController.animateTo(4);
            // setState(() {
            //   _bottomNavIndex=2;
            // });
          },
          backgroundColor: MyColors.primary,
          elevation: 2,
          child: Icon(Icons.search, size: 30, color: MyColors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          elevation: 5,
          backgroundColor: MyColors.primary,
          activeIndex: _bottomNavIndex,
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 0,
          notchSmoothness: NotchSmoothness.sharpEdge,
          gapLocation: GapLocation.center,
          height: 75,
          onTap: (index) {
            tabController.animateTo(index);
            setState(() {
              _bottomNavIndex=index;
            });
          },
          itemCount: 4,
          tabBuilder: (int index, bool isActive) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 30,
                  color: isActive ? MyColors.white :MyColors.white.withOpacity(.6),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(titleList[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? MyColors.white :MyColors.white.withOpacity(.6),
                      )),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
