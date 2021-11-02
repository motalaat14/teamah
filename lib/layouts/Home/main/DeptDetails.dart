import 'package:flutter/material.dart';
import 'package:teamah/helpers/customs/AppBarFoot.dart';

class DeptDetails extends StatefulWidget {
  final int id;
  final String name,img;

  const DeptDetails({Key key, this.id, this.name, this.img}) : super(key: key);

  @override
  _DeptDetailsState createState() => _DeptDetailsState();
}

class _DeptDetailsState extends State<DeptDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.name),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image(image: ExactAssetImage(widget.img)),
          ),
        ],
      ),


      body: Column(
        children: [
          AppBarFoot(),


          Container(
            height: MediaQuery.of(context).size.height*.88,
            child: ListView.builder(
              itemCount: 25,
                itemBuilder: (c,i){
                  return deptItem(
                    img: "https://lh3.googleusercontent.com/proxy/oGbkoFJeZXdLK5PvP1BFk5y--77m3jMjRpqRfOgNiB_1-GFCTtAxXJAA8mnWUU7KrfOEYQYdJKuTQFE-1HJI3S_fv6jGHqPTSg",
                    title: "لوحات الكهرباء الرئيسية"
                  );
                }),
          ),
        ],
      ),



    );
  }


Widget deptItem ({img,title}){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Row(
            children: [
              Image(image: NetworkImage(img),width: 60,height: 60,),
              Text(title,style: TextStyle(fontSize: 18),)
            ],
          ),
          Divider(thickness: 1,),
        ],
      ),
    );
}

}
