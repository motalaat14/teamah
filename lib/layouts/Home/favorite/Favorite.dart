import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> with TickerProviderStateMixin{

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
        appBar: AppBar(
          title: Text(tr("cart")),
          elevation: 0,
        ),
        body: Center(child: Text("favorite")),
      ),
    );
  }
}
