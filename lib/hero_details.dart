import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:super_hero_app/model.dart';

class HeroDetails extends StatefulWidget {
  final HeroItem heroItem;

  HeroDetails({this.heroItem});

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
  String Image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Image = widget.heroItem.images.lg;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Hero(
          tag: widget.heroItem.name,
          child: Text(widget.heroItem.name,style: TextStyle(
            color: Colors.white
          ),),
        ),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: widget.heroItem.images.lg,
                child: CachedNetworkImage(
                  imageUrl: Image,
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
